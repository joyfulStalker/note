@echo off
rem 隐藏命令在第一句使用 @echo off
echo begin!
cd D:\envi\mysql-5.7.25\bin
net stop mysql
echo success!
pause & exit