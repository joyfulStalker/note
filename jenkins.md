本案例 jenkins.war 是放在/opt/jenkins/目录下的
	
centos7使用
    关联文件，/etc/init.d/
	ln -s /opt/jenkins/jenkins.sh /etc/init.d/jenkins         注：   /opt/jenkins/jenkins.sh  路径要写全不然是无效的
	chkconfig --add jenkins
	chkconfig --level 345 jenkins on
Ubuntu使用	
	ln -s /opt/jenkins/jenkins.sh /etc/init.d/jenkins
	update-rc.d -f jenkins defaults



startjenkins.sh

```bash
#!/bin/bash
JENKINS_ROOT=/usr/local/jenkins
export JENKINS_HOME=${JENKINS_ROOT}/home
/usr/local/java/jdk1.8.0.66/bin/java -jar ${JENKINS_ROOT}/jenkins.war --httpPort=8081
```

jenkins.sh

```bash
#!/bin/sh
# chkconfig: 2345 20 90 
# description: jenkins
# This script will be executed *after* all the other init scripts.  
# You can put your own initialization stuff in here if you don't  
# want to do the full Sys V style init stuff.  
#nohup $prefix/start_jenkins.sh >> $prefix/jenkins.log 2>&1 &

JENKINS_ROOT=/usr/local/jenkins
JENKINSFILENAME=jenkins.war

#停止方法
stop(){
    echo "Stoping ${JENKINSFILENAME}"
	ps -ef|grep ${JENKINSFILENAME} |awk '{print $2}'|while read pid
	do
	   kill -9 $pid
	   echo " $pid kill"
	done
}

case "$1" in
start)
    echo "Starting ${JENKINSFILENAME}"
	nohup ${JENKINS_ROOT}/startjenkins.sh >> ${JENKINS_ROOT}/jenkins.log 2>&1 &
  ;;
stop)
  stop
  ;;
restart)
  stop
  start
  ;;
status)
  ps -ef|grep $JENKINSFILENAME
  ;;
*)
  printf 'Usage: %s {start|stop|restart|status}\n' "$prog"
  exit 1
  ;;
esac
```

