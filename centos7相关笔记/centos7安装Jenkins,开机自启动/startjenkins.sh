#!/bin/bash
JENKINS_ROOT=/usr/local/jenkins
export JENKINS_HOME=${JENKINS_ROOT}/home
/usr/local/java/jdk1.8.0.66/bin/java -jar ${JENKINS_ROOT}/jenkins.war --httpPort=8081
