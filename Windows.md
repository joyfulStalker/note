[返回目录](./README.md)
一、bat

1、隐藏命令窗口启动程序

```bat
#方法一（可用）
#在代码头部加一段代码就可以了。
@echo off 　　
if "%1" == "h" goto begin 
mshta vbscript:createobject("wscript.shell").run("%~nx0 h",0)(window.close)&&exit 
:begin 
::下面是你自己的代码
---------------------------------------------------------------------------------------------------
#方法二 （在你批处理的相同目录下新建一个记事本，里面输入：）
DIM objShell set objShell=wscript.createObject("wscript.shell") 
iReturn=objShell.Run("cmd.exe /C c:\1.bat", 0, TRUE) 　　
::（其中win.bat为你自己的批处理名字，自己改）
:: 然后把这个记事本保存为后缀名为.vbe的文件，到时候你只要运行这个vbe文件就达到目的了！
:: 可以写的简单点： 
Set ws = CreateObject("Wscript.Shell") 
ws.run "cmd /c c:\1.bat",0 
:: 或者 
CreateObject("WScript.Shell").Run "cmd /c c:\1.bat",0 
:: （这种写法很多杀软报毒， 需要替换参数0） 
---------------------------------------------------------------------------------------------------	
#bat文件中启动另一个bat文件(其中"Eu"是命令窗口的名字（也可以不写）)
start "Eu" call runEurka.bat
---------------------------------------------------------------------------------------------------
#延时	（20秒）
@ping 127.0.0.1 -n 20 >nul
---------------------------------------------------------------------------------------------------
#示例：
@echo off 　　
if "%1" == "h" goto begin 
    mshta vbscript:createobject("wscript.shell").run("%~nx0 h",0)(window.close)&&exit 
:begin
start "Eu" call runEurka.bat
@ping 127.0.0.1 -n 20 >nul
start "con" call runConf.bat
@ping 127.0.0.1 -n 50 >nul
start "mq" call runMq.bat
```

2、杀死指定端口脚本

```bat
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
```



















