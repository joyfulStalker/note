:隐藏命令
@echo off
echo begin！
netstat -ano|findstr 8888>pid.txt
rem 查找进程记录,提取第5列的值,并终止进程,for 默认会以空格,制表符,;等进行字符串分割
for /f "tokens=5" %%i in (pid.txt) do (
:括号“（”  要位于跟if 同一行，如果不在同一行的话执行时会报语法错误。
	if %%i==0 (
		echo "没有运行在8888端口的进程"
		goto next
	)	else	(
		echo "结束运行在8888端口的进程"
		taskkill /pid %%i /F
		goto next
	)
	
)

:next
del pid.txt
netstat -ano|findstr 8091>pid.txt
for /f "tokens=5" %%i in (pid.txt) do (
	if %%i==0 (
		echo "没有运行在8091端口的进程"
		goto end
	)	else	(
		echo "结束运行在8091端口的进程"
		taskkill /pid %%i /F
		goto end 
	)
)

:end
del pid.txt
echo success!
pause & exit