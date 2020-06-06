#!/usr/bin/env bash

ROOT=$(pwd)
CONFIG=$ROOT/.config.json
RESULT=$ROOT/result
KS=$ROOT/extra/debug.jks
KSP=$ROOT/extra/debug_ks_pass
REPORT=$RESULT/report.txt

function app()
{
  local action="$1"
  shift
  case "$action" in
    "prepare") prepare $*
    ;;
    "do_task") do_task $*
    ;;
  esac
}

function do_task()
{
   rm -rf $RESULT && mkdir -p $RESULT
   local i=0
   while true; do
      local ss=$(jq .task[$i] $CONFIG -r)
      case "$ss" in
        "null"|"---") break;;
        "") continue;;
	*)
	    echo $ss | grep -q "@APK.*"
	    if [ $? -eq 0 ]; then
#	       set -x
  	       declare -a args=($ss)
	       local argc=${#args[@]}
   	       if [ $argc -gt 1 ]; then
	          local subdir=""
	          local name="apk_repo"
	          local url="${args[1]}"
 	          if [ "${args[2]}" != "" ]; then
                     sudir="${args[2]}"
	          fi
 	          if [ "${args[3]}" != "" ]; then
                     name="${args[3]}"
	          fi
#cat << EOF
                  git clone "$url" "$ROOT/$name" -j 4 \
                  && \
	          android_build "$ROOT/${name}/${subdir}"
#EOF
	       else
		  echo "Usage: @APK <url> [name] [subdir]"
		  exit 1
	       fi
            else
               local command="check $ss"
               eval $command
	    fi
	;;
      esac
      ((i++))
   done
}

function prepare()
{
   set_github_env ENABLE_JAVA_ENV   $(jq .env.java $CONFIG -r)
   set_github_env ENABLE_NODE_ENV   $(jq .env.node $CONFIG -r)
   set_github_env ENABLE_PYTHON_ENV $(jq .env.python $CONFIG -r)
   add_github_path $ROOT/tool/bin
   set_github_env ANDROID_KS  $KS
   set_github_env ANDROID_KSP $KSP
}

function check()
{
  echo $1 | tee -a $REPORT
  echo "=======================================================" | tee -a $REPORT
  $1 | tee -a $REPORT
  echo "=======================================================" | tee -a $REPORT
  echo "" | tee -a $REPORT
}

function set_github_env()
{
  if [ $# -eq 2 ]; then
     echo "::set-env name=$1::$2"
  fi
}

function add_github_path()
{
  if [ $# -eq 1 ]; then
     echo "::add-path::$1"
  fi
}

app $*
