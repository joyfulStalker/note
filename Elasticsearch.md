CentOS7.X 安装 Elasticsearch_6.5.1 （配置集群）

1 准备工作
	CentOS 7.X 64位系统
	安装jdk 1.8，这个是最低要求 （*测试openjdk 可用）
	下载 elasticsearch-6.5.1.tar.gz 压缩包

2 安装和运行
	（1）解压压缩包。

	tar -zxvf elasticsearch-6.5.1.tar.gz
	1
	（2）在/opt下新建文件夹 dev-env，并将解压后的 elasticsearch-6.5.1 移动到 /opt/dev-env/ 下面。
	
	mv elasticsearch-6.5.1/ /opt/dev-env/
	1
	elasticsearch不允许root用户启动运行。所以，需要为普通用户赋权限。
	
	注意：以下创建用户和赋权限的操作都需要先切换为root用户才行。
	
	（3）创建一个普通用户es-admin 。
	
	useradd elas
	
	（4）为用户es-admin创建密码，连续输入两次密码。
	
	passwd elas
	
	（5）创建一个用户组es。
	
	groupadd es
	
	（6）分配用户es-admin到用户组es中。
	
	usermod -G es es-admin
	1
	（7）进入elasticsearch-6.5.1根目录。
	
	cd /opt/dev-env/elasticsearch-6.5.1
	1
	（8）给用户es-admin赋予权限，-R表示逐级（N层目录） ， *表示 任何文件。
	
	chown -R elas.es *
	
	（9）切换到es-admin用户。
	
	su elas
	
	（10）启动 elasticsearch-6.5.1 的 bin目录下的elasticsearch。如果想要在后台运行，加一个参数-d。
	
	cd /opt/dev-env/elasticsearch-6.5.1
	./bin/elasticsearch
	
	后台运行：
	
	./bin/elasticsearch -d
	
	（11）关闭后台运行的elasticsearch。
	
	首先，查看进程号：
	
	ps -ef|grep elasticsearch
	
	然后，杀掉进程：
	
	# 14056 是你查到的进程号
	kill -9 14056
	
	基本参数配置
	# 修改elasticsearch的配置文件
	vim ./config/elasticsearch.yml
	
	# cluster.name 指定集群名称
	cluster.name: cluster
	# node.name 指定节点名称
	node.name: node-1
	# network.host 指定elasticsearch服务器的地址，如果需要远程访问，那么就需要配置这个地址
	network.name: 192.168.137.128
	# http.port 指定服务的端口
	http.port: 9200

4 运行测试
	（1）本地测试

	执行如下命令，注意192.168.137.128是在配置文件里配置的network.name。
	
	curl -X GET 192.168.137.128:9200
	
	得到返回的json数据：
	
	{
	"name" : "node-1",
	"cluster_name" : "es-admin-application",
	"cluster_uuid" : "N8kQ7LGjTLiLh5-WR3KAZA",
	"version" : {
	"number" : "6.5.1",
	"build_flavor" : "default",
	"build_type" : "tar",
	"build_hash" : "8c58350",
	"build_date" : "2018-11-16T02:22:42.182257Z",
	"build_snapshot" : false,
	"lucene_version" : "7.5.0",
	"minimum_wire_compatibility_version" : "5.6.0",
	"minimum_index_compatibility_version" : "5.0.0"
	},
	"tagline" : "You Know, for Search"
	}


	（2）远程测试
	
	直接在浏览器中输入http://192.168.137.128:9200，同样返回上面的json数据。