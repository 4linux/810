if [ "$1" = "debian/buster64" ]; then
  apt update > /dev/null 2>&1  && echo "[OK] APT source list updated"
  apt install -y vim chrony gnupg2 pass> /dev/null 2>&1  && echo "[OK] vim and chrony installed"
else
  dnf install -y epel-release
  dnf install vim chrony -y  
  sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config > /dev/null 2>&1  && echo "[OK] SELinux disabled"
fi 

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config > /dev/null 2>&1  && echo "[OK] Allow SSH with Password"
systemctl restart sshd



cat <<EOF > /etc/hosts
127.0.0.1 localhost.localdomain localhost
192.168.100.10 mongos.example.com mongos
192.168.100.11 configsvr-01.example.com configsvr-01
192.168.100.12 configsvr-02.example.com configsvr-02
192.168.100.13 shard-01.example.com shard-01 sh0-01
192.168.100.14 shard-02.example.com shard-02 sh0-02
192.168.100.15 shard-03.example.com shard-03 sh1-01
192.168.100.16 shard-04.example.com shard-04 sh1-02
192.168.100.256 monitoring.example.com monitoring
EOF

