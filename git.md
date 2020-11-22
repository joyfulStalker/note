[TOC]

# 一：git常见命令

```bash
git init   #初始化版本库
git add .   #添加文件到版本库（只是添加到缓存区），.代表添加文件夹下所有文件 
git commit -m "first commit" #把添加的文件提交到版本库，并填写提交备注
##推送到远端
git remote add origin 你的远程库地址  #把本地库与远程库关联
git push -u origin master    #第一次推送时
git push origin master  #第一次推送后，直接使用该命令即可推送修改
```



# 二：常见错误

## 1、errno 10054

```shell
#github RPC failed; curl 56 OpenSSL SSL_read: SSL_ERROR_SYSCALL, errno 10054
#出现此问题有可能是上传大小限制： 
#执行如下命令
git config http.postBuffer 524288000
```

## 2、curl 56 OpenSSL SSL_read:SSL_ERROR_sysCALL

```bash
git config http.sslVerify "false"
```

# 三：安装gitlab

```shell
#gitlab默认是重启的
1、安装本地环境插件
$: yum install yum-plugin-downloadonly
# 缓存源（少，可以不缓存） 不安装
$: yum install --downloadonly --downloaddir=/data curl policycoreutils-python openssh-server
$: systemctl enable sshd
$: systemctl start sshd
$: firewall-cmd --permanent --add-service=http
$: systemctl reload firewalld
# 安装邮箱 (不用可以不安装)
$: yum install postfix
$: systemctl enable postfix
$: systemctl start postfix
# 添加清华的gitlab源 
$: cat <<EOF > /etc/yum.repos.d/gitlab-ce.repo
	[gitlab-ce]
	name=Gitlab CE Repository
	baseurl=https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/yum/el7/
	gpgcheck=0
	enabled=1
	EOF
# 刷新缓存 （gitlab源比较大，建议缓存）
$: yum makecache
# 安装最新版。此处可以指定版本 比如yum install gitlab-ce-10.2.4
$: yum install gitlab-ce


2. 修改配置
$: vi /etc/gitlab/gitlab.rb   (核心文件)
    # 修改该行
    external_url 'http://10.180.4.94'
    # 关闭smtp，发信系统用的默认的postfix,smtp是默认开启的,两个都启用了,两个都不会工作. 
    gitlab_rails['smtp_enable'] = false	
$: vi /opt/gitlab/embedded/service/gitlab-rails/config/gitlab.yml.example
	##修改gitlab
    host：要修改的IP
    port：要修改的端口
# 重启
$: gitlab-ctl reconfigure
$: gitlab-ctl restart

3.访问浏览器打开：http://10.180.4.94
4. 常用命令
$: cat /opt/gitlab/embedded/service/gitlab-rails/VERSION 	#获取版本号
$: gitlab-ctl start    		# 启动所有 gitlab 组件
$: gitlab-ctl stop        	# 停止所有 gitlab 组件
$: gitlab-ctl restart       # 重启所有 gitlab 组件
$: gitlab-ctl status        # 查看服务状态
$: gitlab-ctl reconfigure   # 启动服务
$: gitlab-ctl tail          # 查看日志
```


​	


​		





