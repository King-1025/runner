@echo off

echo 开始安装virtualenv...
pip install virtualenv
echo

rem echo 创建fitx虚拟环境
rem virtualenv fitx
rem echo

rem for Windows users
echo 开始安装virtualenvwrapper-win
pip install virtualenvwrapper-win
echo

echo 你可以设置环境变量: WORKON_HOME 作为python虚拟环境的存放目录。
setx /m WORKON_HOME %RESULT%
rem pause
echo RESULT: %RESULT%
