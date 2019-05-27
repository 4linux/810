# MongoDB-Lab




## Running Vagrantfile

```SH
# vagrant up 
```

By now you should have 3 CentOS 7.X servers running 

```SH
# vagrant status
Current machine states:

mongodb-node01            running (virtualbox)
mongodb-node02            running (virtualbox)
mongodb-node03            running (virtualbox)

```

## Installing MongoDB

First of all, ssh in one of the machines and copy the mongodb.repo from the /vagrant to /etc/yum.repos.d

```SH
$ sudo su -
# cp /vagrant/mongodb.repo /etc/yum.repos.d/
```
Now, update the list of repositories and install mongodb-org package.

```SH
# yum repolist
# yum install -y mongodb-org
```

Enable MongoDB on systemd and start mongod.service

```SH
# systemctl enable mongod.service
# systemctl start mongod.service
```

By now you should have a mongd process running on this machine, type mongo and see if you are droped to a mongo-shell environment.

```SH
# mongo
>
```

