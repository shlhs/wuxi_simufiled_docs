# wuxi_simufiled_docs

无锡仿真后台服务 

## How to deploy

### 环境准备
 - Linux系统的PC或服务器, 推荐使用Ubuntu14.04:    
```Bash
root@iZ28yy5kssxZ:~# lsb_release -a 
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 14.04.4 LTS
Release:	14.04
Codename:	trusty
```
 - 安装java运行环境(1.8)，结果如下:    
```shell
root@iZ28yy5kssxZ:~# java -version
java version "1.8.0_101"
Java(TM) SE Runtime Environment (build 1.8.0_101-b13)
Java HotSpot(TM) 64-Bit Server VM (build 25.101-b13, mixed mode)
```
 - 安装图片服务器[thumbor](http://thumbor.readthedocs.io/en/latest/index.html), 版本不低于v6.0.1, 结果如下:    
```shell
root@iZ28yy5kssxZ:~# thumbor --version
Thumbor v6.0.1 (22-Mar-2016)
```     

 - 安装进程管理工具[Supervisor](http://www.supervisord.org), 版本不低于3.3.1, 结果如下:   
```shell
root@iZ28yy5kssxZ:~# supervisord --version
3.3.1
```
 - 准备Mysql Service，可直接使用已有，___需修改mysql的配置 max_allowed_packet=1024\*1024\*48、innodb_log_file_size=140M___; 创建相应DB及其TABLE；以在此台机器上，可连接到数据库为结果。可以直接运行sql附件文件（simufiled_stru），具体[sql](https://github.com/shlhs/wuxi_simufiled_docs/blob/master/sql_back/simufiled_stru.sql)如下：  
```sql
CREATE DATABASE  IF NOT EXISTS `simufiled` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `simufiled`;

DROP TABLE IF EXISTS `Scene`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Scene` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `content` mediumtext,
  `designer` varchar(50) DEFAULT NULL,
  `practiser` varchar(50) DEFAULT NULL,
  `assigner` varchar(50) DEFAULT NULL,
  `parentID` int(4) DEFAULT NULL,
  `practiseStatus` varchar(20) DEFAULT NULL,
  `practiseLog` mediumtext,
  `practiseResult` varchar(20) DEFAULT NULL,
  `practiserCatagory` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2462 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

```
 - 准备好后台用户管理系统，以http://ip:port/viot/api/ 相关接口可用为结果, 注意更新下文中的usermanager.url。   
 
###准备资源文件, 具体文件见[附件](https://github.com/shlhs/wuxi_simufiled_docs/blob/master/deploy_config)
 - 服务运行软件包，simufiled-svc-1.0.0.jar (./ 目录下)
 - 图片存取服务配置，[thumbor.conf](https://github.com/shlhs/wuxi_simufiled_docs/blob/master/deploy_config/thumbor/thumbor.conf) (./thumbor 目录下)
 - 服务启动配置文件 [supervisord_thumber_websvc.conf](https://github.com/shlhs/wuxi_simufiled_docs/blob/master/deploy_config/supervisord_thumber_websvc.conf) (./ 目录下)，需根据实际情况修改，simufiled-svc-1.0.0.jar所在位置、服务启动参数（数据库信息、对外端口等）、log存储路径:     
  ***/home/simufiled/ 需根据实际进行替换;***      
  ***thumbor --port=8888 --conf=/home/simufiled/thumbor/thumbor.conf 根据需要修改图片存取服务的端口与配置文件所在位置;***                    
  ***java -jar 根据实际情况调整 数据库信息，后台用户管理系统usermanager.url等信息***          
  根据需要调整其他次要信息，例如log路径等，进一步信息可参考[Supervisor](http://www.supervisord.org)      
```ini
[supervisord]
logfile = /home/simufiled/logs/supervisord.log
logfile_maxbytes = 50MB
logfile_backups=10
loglevel = info
pidfile = /home/simufiled/supervisord.pid
user = root

[program:thumbor]
command=thumbor --port=8888 --conf=/home/simufiled/thumbor/thumbor.conf
process_name=thumbor8888
numprocs=1
user=root
directory=/home/simufiled/thumbor/
autostart=true
autorestart=true
startretries=3
stopsignal=TERM
stdout_logfile=/home/simufiled/thumbor/logs/thumbor8888.stdout.log
stdout_logfile_maxbytes=1MB
stdout_logfile_backups=10
stderr_logfile=/home/simufiled/thumbor/logs/thumbor8888.stderr.log
stderr_logfile_maxbytes=1MB
stderr_logfile_backups=10

[program:wuxiwebsvc]
command=java -jar /home/simufiled/simufiled-svc-1.0.0.jar --server.port=8090 --spring.datasource.url=jdbc:mysql://127.0.0.1:3306/simufiled --spring.datasource.username=root --spring.datasource.password=xxxx --usermanager.url=http://114.215.90.83:8082/viot/api/
process_name=wuxiwebsvc
numprocs=1
user=root
directory=/home/simufiled/websvc/
autostart=true
autorestart=true
startretries=3
stopsignal=TERM
stdout_logfile=/home/simufiled/websvc/logs/websvc.stdout.log
stdout_logfile_maxbytes=1MB
stdout_logfile_backups=10
stderr_logfile=/home/simufiled/websvc/logs/wensvc.stderr.log
stderr_logfile_maxbytes=1MB
```

###启动运行    
通过以上述b配置文件，运行supervisord即可     
```shell
supervisord -c ./supervisord_thumber_websvc.conf
```

###检查相关进程是否运行，正常情况下一共有三个相关进程（java、thumbor、supervisord）正在运行，结果如下:    
```shell
root@iZ28yy5kssxZ:~# ps -ef | grep thum
root      1515     1  0 Nov13 ?        00:01:20 /usr/bin/python /usr/local/bin/supervisord -c ./supervisord_thumber_websvc.conf
root      1516  1515  0 Nov13 ?        00:00:00 /usr/bin/python /usr/local/bin/thumbor --port=8888 --conf=/home/simufiled/thumbor/thumbor.conf
root     29966 29940  0 23:15 pts/5    00:00:00 grep --color=auto thum
root@iZ28yy5kssxZ:~# ps -ef | grep simufiled-svc
root      1517  1515  0 Nov13 ?        00:06:02 java -jar /home/simufiled/simufiled-svc-1.0.0.jar --server.port=8090 --spring.datasource.url=jdbc:mysql://127.0.0.1:3306/simufiled --spring.datasource.username=root --
```

###检查业务是否正常
 - 服务后台，http://ip:port/login, 可正常访问，输入正确的用户信息，可登录；输入错误的用户信息，则返回401认证失败。
 - 图片存储服务，可使用thumbor的[rest-api](http://thumbor.readthedocs.io/en/latest/how_to_upload_images.html)进行测试检测；也可直接在仿真软件的桌面客户端上直接进行相关的验证。
 
### FAQ
#### 安装或运行图片服务器thumbor失败，出现关于pycurl的错误
过程中如遇到无法安装依赖pycurl，或者运行显示缺少pycurl, 问题现象如下:
```shell
root@iZ28yy5kssxZ:/home/simufiled# pip install thumbor
.....
....
...
----------------------------------------
Cleaning up...
Command python setup.py egg_info failed with error code 1 in /tmp/pip_build_root/pycurl
Storing debug log for failure in /root/.pip/pip.log

root@iZ28yy5kssxZ:/home/simufiled# thumbor --version
Traceback (most recent call last):
  File "/usr/local/bin/thumbor", line 5, in <module>
    from pkg_resources import load_entry_point
  File "/usr/lib/python2.7/dist-packages/pkg_resources.py", line 2749, in <module>
    working_set = WorkingSet._build_master()
  File "/usr/lib/python2.7/dist-packages/pkg_resources.py", line 444, in _build_master
    ws.require(__requires__)
  File "/usr/lib/python2.7/dist-packages/pkg_resources.py", line 725, in require
    needed = self.resolve(parse_requirements(requirements))
  File "/usr/lib/python2.7/dist-packages/pkg_resources.py", line 628, in resolve
    raise DistributionNotFound(req)
pkg_resources.DistributionNotFound: pycurl>=7.19.0,<7.44.0
```
  解决办法：手动或通过其他方式安装pycurl,例如    
```shell
sudo aptitude install python-pycurl
```
  更多安装方式，参看[链接](http://stackoverflow.com/questions/507927/how-do-i-install-pycurl)
