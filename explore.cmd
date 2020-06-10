@echo off
setlocal enabledelayedexpansion

set "ROOT=%CD%"
set "CONFIG=%ROOT%&\.config.json"
set "RESULT=%ROOT%\result"
set "KS=%ROOT%\extra\debug.jks"
set "KSP=%ROOT%\extra\debug_ks_pass"
set "REPORT=%RESULT%\report.txt"
set "MTEMP=%TEMP%\.explore"

rem app全局执行函数
:app
setlocal
set "action=%~1"
call:%action%
endlocal
goto:eof

rem 勘测准备函数
:prepare
echo 准备...
call:set_github_env ENABLE_PYTHON_ENV true
call:set_github_env ANDROID_KS "%KS%"
call:set_github_env ANDROID_KSP "%KSP%"
call:set_github_env RESULT "%RESULT%"
call:add_github_path "%ROOT%\tool\bin"
md %RESULT%
goto:eof

rem 勘测执行函数
:do_task
echo 执行...
rem call:check "ipconfig"
call:check ".\script\fitx修复安装.cmd"
goto:eof

rem 检测命令
:check
set "command=%~1"
call:strtee "%command%" "%REPORT%"
call:strtee "=======================================================" "%REPORT%"

%command% > %MTEMP% && type %MTEMP% && type %MTEMP% >> %REPORT% && del %MTEMP%

call:strtee "=======================================================" "%REPORT%"
call:strtee "." "%REPORT%"
goto:eof

rem 简略tee命令实现
:strtee
echo %~1
echo %~1 >> %~2
goto:eof

rem 设置github环境变量
:set_github_env
echo ::set-env name=%~1::%~2
goto:eof

rem 添加github path环境变量
:add_github_path
echo ::add-path::%~1
goto:eof

call:app %*
