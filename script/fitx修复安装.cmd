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
rem pause

echo 使用mkvirtualenv，创建fitx虚拟环境
mkvirtualenv fitx
echo

echo 当前已经创建的虚拟环境如下：
lsvirtualenv
echo

echo 开始测试python虚拟环境...

echo 1.测试进入虚拟环境fitx...
workon fitx
echo
echo 2.测试退出虚拟环境fitx...
deactivate
echo

echo 3.python虚拟环境验证完毕！
rem pause
