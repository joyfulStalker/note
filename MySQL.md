知识点



```mysql
union和 union all 的差别是前者会忽略重复数据，后者不会。
```





# 二、linux













# 三、Windows

## 1、安装MySql 8.0.13（Win 7）

```ini
1、下载zip安装包 下载地址 https://dev.mysql.com/downloads/mysql/
2、安装前操作
解压到安装目录、配置环境变量	D:\develop\MySQL\mysql-8.0.13
配置初始化的my.ini文件（在D:\develop\MySQL\mysql-8.0.13下，没有的话自己创建，以下是my.ini的内容，copy进去）
-----------------------------------------------------------------------------------------------------
[mysqld]
# 设置3306端口
port=3306
# 设置mysql的安装目录
basedir=D:\\develop\\MySQL\\mysql-8.0.13   # 切记此处一定要用双斜杠\\，单斜杠我这里会出错，不过看别人的教程，有的是单斜杠。自己尝试吧
# 设置mysql数据库的数据的存放目录
datadir=D:\\develop\\MySQL\\mysql-8.0.13\\Data   # 此处同上
# 允许最大连接数
max_connections=200
# 允许连接失败的次数。这是为了防止有人从该主机试图攻击数据库系统
max_connect_errors=10
# 服务端使用的字符集默认为UTF8
character-set-server=utf8
# 创建新表时将使用的默认存储引擎
default-storage-engine=INNODB
# 默认使用“mysql_native_password”插件认证
default_authentication_plugin=mysql_native_password
[mysql]
# 设置mysql客户端默认字符集
default-character-set=utf8
[client]
# 设置mysql客户端连接服务端时默认使用的端口
port=3306
default-character-set=utf8
-----------------------------------------------------------------------------------------------------
3、安装mysql
   ①、以管理员身份运行cmd，进入安装目录下的bin目录，执行mysqld --initialize --console
   ②、执行完成后，会打印 root 用户的初始默认密码（如：root@localhost: rI5rvf5x5G,E），记录之。在没有更改密码前，需要记住这个密码，后续登录需要用到。
   ③、执行mysqld --install  
	 命令mysqld --install [服务名]  后面的服务名可以不写，默认的名字为 mysql。当然，如果你的电脑上需要安装多个MySQL服务，就可以用不同的名字区分了，比如 mysql5 和 mysql8。
   ④、net start mysql 启动服务
注：
1、在第三步的时候，启动服务可能会报服务名无效或者MySQL正在启动 MySQL无法启动
原因：因为net start +服务名，启动的是win下注册的服务。此时，系统中并没有注册mysql到服务中。即当前路径下没有mysql服务。
2、卸载：通过命令sc delete MySQL/mysqld -remove卸载 MySQL 服务
参考：http://www.cnblogs.com/laumians-notes/p/9069498.html
	 https://blog.csdn.net/ermaner666/article/details/79096939/
```







## 2、MySql启动脚本

```

```



## 3、MySql停止脚本（bat文件 stop.bat）

```
@echo off
rem 隐藏命令在第一句使用 @echo off
echo begin!
cd D:\envi\mysql-5.7.25\bin
net stop mysql
echo success!
pause & exit
```

