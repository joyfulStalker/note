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
