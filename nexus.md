
[返回目录](./README.md)

1、下载 Nexus3.13

下载地址:https://help.sonatype.com/repomanager3/download/download-archives---repository-manager-3，下载指定的版本。

2、上传nexus-3.13.0-01-unix.tar.gz到 /usr/local/

3、解压

```shell
$: mkdir nexus
$: tar -zxvf nexus-3.13.0-01-unix.tar.gz  -C nexus
$: cd nexus
$: ls		## nexus-3.13.0-01  sonatype-work (一个 nexus 服务，一个私有库目录)

```

4、编辑 Nexus 的 nexus.properties 文件,配置端口和 work 目录信息（保留默认）

```shell
$: cd nexus-3.13.0-01/
$: ls	## bin deploy etc lib NOTICE.txt OSS-LICENSE.txt PRO-LICENSE.txt public system
$: cd ./etc/
$: vi nexus-default.properties    #查看目录结构，jetty 运行
	#修改运行端口为18080
	# Jetty section
	application-port=18080
	application-host=0.0.0.0
	nexus-args=${jetty.etc}/jetty.xml,${jetty.etc}/jetty-http.xml,${jetty.etc}/jetty-requestlog.xml
	nexus-context-path=/
	# Nexus section
	nexus-edition=nexus-pro-edition
	nexus-features=\
	nexus-pro-feature
```

5、安装运行

```shell
$: cd ..
$: ./bin/nexus start
```

6.登录 

   访问 http://10.180.4.223:18080

   默认用户/密码  admin/admin123

8.修改中央仓库地址

   改为阿里云的镜像 http://maven.aliyun.com/nexus/content/groups/public/

9.开机自启动

```shell
$: vi /etc/rc.local
$: /usr/local/nexus/nexus-3.13.0-01/bin/nexus start	#添加启动命令  
```

注：登入界面发现一个警告“System Requirement: max file descriptors [4096] likely too low, increase to at least [65536].”

在/etc/security/limits.conf添加下面两行

```shell
soft nofile 65536
hard nofile 65536
```



重启服务

开机自启动
1、进入到/etc/init.d目录下，新建一个nexus脚本

```shell
$: cd /etc/init.d
$: vi nexus
```

###脚本可在当前路径查看

###脚本可在当前路径查看

```bash
#!/bin/bash
#chkconfig:2345 20 90    
#description:nexus    
#processname:nexus    
export JAVA_HOME=/usr/local/java/jdk1.8.0_191/
case $1 in    
        start) su root /usr/local/nexus/nexus-3.14.0-04/bin/nexus start;;    
        stop) su root /usr/local/nexus/nexus-3.14.0-04/bin/nexus stop;;    
        status) su root /usr/local/nexus/nexus-3.14.0-04/bin/nexus status;;    
        restart) su root /usr/local/nexus/nexus-3.14.0-04/bin/nexus restart;;    
		dump ) su /usr/local/nexus/nexus-3.14.0-04/bin/nexus dump ;; 
        console ) su root /usr/local/nexus/nexus-3.14.0-04/bin/nexus console ;;  		
        *) echo "require console | start | stop | restart | status | dump " ;;    
esac
```

2.给脚本添加执行权限
	chmod +x nexus
3.使用service nexus start/stop命令来尝试启动关闭nexus，使用servicenexus status查看nexus状态。或者直接 nexus start/stop/status
4.添加到开机启动
	chkconfig --addnexus 
5.查看开机自启的服务中是否已经有我们的nexus 
	chkconfig --listnexus 
