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

##不生效 可以用软连接
##或者手动  source /etc/profile 使java环境生效
##source /etc/profile
