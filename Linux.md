[TOC]


[返回目录](./README.md)
# 一：centos7

## 1、新机器配置、软件安装

```shell
#初次使用c7时
##修改动态IP为静态(确定可用IP范围。如果使用VMware，可以在设置动态ip起止范围)

#①、网络配置
##修改linux网络配置
$: vi /etc/sysconfig/network-scripts/ifcfg-（一般第一个）
	#修改
	BOOTPROTO=static #这里讲dhcp换成static
	ONBOOT=yes #将no换成yes（如果no  使用yum安装时会报 Error: cannot find a valid baseurl or repo:base）
	#新增
	IPADDR=192.168.100.200 #静态IP
	GATEWAY=192.168.100.2 #默认网关
	NETMASK=255.255.255.0 #子网掩码
	DNS1=8.8.8.8 #dns配置 解析域名
##保存退出后,重启网络服务:
$: service network restart
#此时就可以使用远程工具连接了（centos7默认有）

#②、yum安装报错
## "Cannot find a valid baseurl for repo: base/7/x86_64"
## "Could not resolve host: mirrorlist.centos.org; Unknown error"的解决方法
## 原因：这是因为域名解析不了，修改配置
$: vi /etc/resolv.conf
	#然后添加
	nameserver 8.8.8.8 
	nameserver 8.8.4.4 
	serchdomain root
#③、yum安装软件
##centos7下使用yum安装ifconfig、wget等工具(yum search 要安装的工具   来搜索)
$: yum search ifconfig
$: yum install net-tools.x86_64

$: yum search wget
$: yum install wget.x86_64
	
#④、防火墙命令
##1、firewalld的基本使用(systemctl是CentOS7的服务管理工具中主要的工具，它融合之前service和chkconfig的功能于一体。)
$: systemctl start firewalld	##启动
$: systemctl stop firewalld	##关闭
$: systemctl status firewalld	##查看状态
$: systemctl disable firewalld	##开机禁用
$: systemctl enable firewalld	##开机启用
##或者
$: systemctl start firewalld.service	  ##启动一个服务
$: systemctl stop firewalld.service	  ##关闭一个服务
$: systemctl restart firewalld.service	  ##重启一个服务
$: systemctl status firewalld.service	  ##显示一个服务的状态
$: systemctl enable firewalld.service	  ##在开机时启用一个服务
$: systemctl disable firewalld.service	  ##在开机时禁用一个服务
$: systemctl is-enabled firewalld.service ##查看服务是否开机启动
$: systemctl list-unit-files|grep enabled ##查看已启动的服务列表
$: systemctl --failed			  ##查看启动失败的服务列表

##2、对端口操作命令
#添加：（--permanent永久生效，没有此参数重启后失效）
$: firewall-cmd --zone=public --add-port=80/tcp --permanent    
$: firewall-cmd --reload					#重新载入
$: firewall-cmd --zone=public --query-port=80/tcp		#查看
$: firewall-cmd --zone=public --remove-port=80/tcp --permanent	#删除
##3、配置firewalld-cmd
$: firewall-cmd --version					#查看版本
$: firewall-cmd --help						#查看帮助
$: firewall-cmd --state						#显示状态
$: firewall-cmd --zone=public --list-ports	  		#查看所有打开的端口 
$: firewall-cmd --reload					#更新防火墙规则
$: firewall-cmd --get-active-zones			 	#查看区域信息
$: firewall-cmd --get-zone-of-interface=eth0  			#查看指定接口所属区域
$: firewall-cmd --panic-on					#拒绝所有包
$: firewall-cmd --panic-off					#取消拒绝状态
$: firewall-cmd --query-panic				 	#查看是否拒绝


##⑤、telnet安装与使用
#先检查是否安装: telnet-server和xinetd
$: rpm -qa telnet-server
$: rpm -qa xinetd
#如果没有安装，则安装：
#查看可安装的telnet： 
$: yum list |grep telnet
   telnet.x86_64                               1:0.17-64.el7              base     
   telnet-server.x86_64                        1:0.17-64.el7              base 
#查看可安装的xinetd： 
$: yum list |grep xinetd
   xinetd.x86_64                               2:2.3.15-13.el7            base  
#执行安装：
$: yum -y install telnet-server.x86_64
$: yum -y install telnet.x86_64
$: yum -y install xinetd.x86_64

#查看软件是否安装
因为linux安装软件的方式比较多，所以没有一个通用的办法能查到某些软件是否安装了。
总结起来就是这样几类：
1、rpm包安装的，可以用rpm -qa看到，如果要查找某软件包是否安装，用 rpm -qa | grep 软件或者包的名字
$: rpm -qa | grep ruby
2、以deb包安装的，可以用dpkg -l能看到。如果是查找指定软件包，用dpkg -l | grep 软件或者包的名字
$: dpkg -l | grep ruby
3、yum方法安装的，可以用yum list installed查找，如果是查找指定包，命令后加 | grep 软件名或者包名
$: yum list installed | grep ruby
4、如果是以源码包自己编译安装的，例如.tar.gz或者tar.bz2形式的，这个只能看可执行文件是否存在了，
上面两种方法都看不到这种源码形式安装的包。如果是以root用户安装的，可执行程序通常都在/sbin:/usr/bin目录下。
说明：其中rpm yum 是Redhat系linux的软件包管理命令，dpkg是debian系列的软件包管理命令
```




# 二：Ubuntu

## 1、安装jdk8 

```shell
#或者直接根据提示安装openjdk
##首先添加ppa 				
$: sudo add-apt-repository ppa:webupd8team/java
#然后更新系统,刷新软件源 	
$: sudo apt-get update
#最后开始安装 				
$: sudo apt-get install oracle-java8-installer
#查看jdk版本					
$: java -version
#怎么找到自己的java安装路径,命令行的最后，显示的就是jdk安装的路径
$: java -verbose	
```

## 2、安装Jenkins

```shell
#简单来说需要下面四步：
$: wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
$: sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
$: sudo apt-get update
$: sudo apt-get install jenkins

#创建一个名为Jenkins的Linux用户
$: sudo cat /etc/shadow //不知道干啥用	jenkins:x:124:130:Jenkins,,,:/var/lib/jenkins:/bin/bash
```

## 3、mysql安装

```shell
$: sudo apt-get install mysql-server
$: apt-get isntall mysql-client
$: sudo apt-get install libmysqlclient-dev

#改密码 v: 5.7
#修改不了密码，可以用以下来修改
$: use mysql;
$: update mysql.user set authentication_string=PASSWORD('root'), plugin='mysql_native_password' where user='root';
$: update user set host = '%' where user = 'root';
$: flush privileges;
#修改	（注释掉）bind-address = 127.0.0.1
$: vim /etc/mysql/mysql.conf.d/mysqld.cnf	
```


# 三：通用

## 1、linux运行jar包命令

```shell
#启动

#当前ssh窗口被锁定，可按CTRL + C打断程序运行，或直接关闭窗口，程序退出
$: java -jar shareniu.jar

#当前ssh窗口不被锁定，但是当窗口关闭时，程序中止运行。&代表在后台运行。
$: java -jar shareniu.jar &
	   
#nohup 意思是不挂断运行命令,当账户退出或终端关闭时,程序仍然运行。当用 nohup 命令执行作业时，缺省情况下该作业的所有输出被重定向到nohup.out的文件中，除非另外指定了输出文件。
$: nohup java -jar shareniu.jar &

#temp.txt是将command的输出重定向到out.file文件，即输出内容不打印到屏幕上，而是输出到out.file文件中。可通过jobs命令查看后台运行任务
$: nohup java -jar shareniu.jar >temp.txt &
	   
#关闭
#把java运行的端口查出来
$: echo $! > java.pid	
#杀掉进程	
$: kill -9 端口号
	
#java.net.BindException: 地址已在使用
#查看出错的端口，可以获取到pid
$: netstat -alnp | grep 
$: kill - 9  pid

#查看java运行的进程 两者都可以
$: ps -ef|grep java
$: jps
```

## 2、tail 常用命令

```shell
#监视filename文件的尾部内容（默认10行，相当于增加参数 -n 10），刷新显示在屏幕上。退出，按下CTRL+C。
$: tail -f filename

#显示filename最后20行。
$: tail -n 20 filename

#说明：逆序显示filename最后10行
$: tail -r -n 10 filename
```

## 3、tar命令

```shell
#解压tar.gz文件到指定目录
$: tar zxvf test.tgz -C 目录
```

## 4、ssh免密登录

```shell
#登录到普通用户免密登录（当前用户shellstudy，以下操作均在当前用户下操作）
1、执行 ssh-keygen 生成私钥公钥对，一直输入回车即可
2、去当前用户的根目录下查看公钥	cat ~/.ssh/id_rsa.pub
3、将公钥推送到远端服务器上	ssh-copy-id -i ~/.ssh/id_rsa.pub shelltest@192.168.20.152 
（需要输入shelltest@192.168.20.152 的密码，因为此时是吧公钥考到shelltest上）
4、测试登录（无需密码） ssh shelltest@192.168.20.152
#登录到root用户的话免密登录
可以完全参照上面的来做，当然了第三步和第四步可以省去登录名shelltest，
即
3、将公钥推送到远端服务器上 ssh-copy-id -i ~/.ssh/id_rsa.pub 192.168.20.152 
4、测试登录（无需密码） ssh 192.168.20.152
```

## 5、端口占用查看

```bash
$:lsof -i:8080
$: netstat -tunlp|grep 8080
```


# 四：常见错误

1、The remote system refused the connection   

```shell
#远端工具连接linux服务器时报这个问题
#原因：Linux系统里面没有安装openssh-server。
$: sudo apt-get install openssh-server 
#重新连接
```


# 五：自己实现的脚本

## 1、自动安装java环境

##不生效 可以用软连接
##或者手动  source /etc/profile 使java环境生效
##source /etc/profile

```shell
#! /bin/bash
##定义java安装路径变量，方便修改
JAVA_ROOT=/usr/local/myinstall/java/jdk1.8.0.66
##要解压的文件名
GZ_NAME=./jdk-8u66-linux-x64.gz

mkdir -p $JAVA_ROOT
tar -zxvf $GZ_NAME -C $JAVA_ROOT --strip-components 1
echo "JAVA_HOME=$JAVA_ROOT" >> /etc/profile
echo "CLASSPATH=\$JAVA_HOME/lib/" >> /etc/profile
echo "PATH=\$PATH:\$JAVA_HOME/bin" >> /etc/profile
echo "export PATH JAVA_HOME CLASSPATH" >> /etc/profile
```
