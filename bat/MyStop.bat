:��������
@echo off
echo begin��
netstat -ano|findstr 8888>pid.txt
rem ���ҽ��̼�¼,��ȡ��5�е�ֵ,����ֹ����,for Ĭ�ϻ��Կո�,�Ʊ��,;�Ƚ����ַ����ָ�
for /f "tokens=5" %%i in (pid.txt) do (
:���š�����  Ҫλ�ڸ�if ͬһ�У��������ͬһ�еĻ�ִ��ʱ�ᱨ�﷨����
	if %%i==0 (
		echo "û��������8888�˿ڵĽ���"
		goto next
	)	else	(
		echo "����������8888�˿ڵĽ���"
		taskkill /pid %%i /F
		goto next
	)
	
)

:next
del pid.txt
netstat -ano|findstr 8091>pid.txt
for /f "tokens=5" %%i in (pid.txt) do (
	if %%i==0 (
		echo "û��������8091�˿ڵĽ���"
		goto end
	)	else	(
		echo "����������8091�˿ڵĽ���"
		taskkill /pid %%i /F
		goto end 
	)
)

:end
del pid.txt
echo success!
pause & exit