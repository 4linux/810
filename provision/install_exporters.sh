
#
# Download Node and MongoDB exporter
#
cd /tmp

mkdir mongodb_exporter
curl -OL https://github.com/percona/mongodb_exporter/releases/download/v0.11.2/mongodb_exporter-0.11.2.linux-amd64.tar.gz
tar -xf mongodb_exporter-0.11.2.linux-amd64.tar.gz -C mongodb_exporter

mkdir node_exporter
curl -OL https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz
tar -xf node_exporter-1.0.1.linux-amd64.tar.gz -C node_exporter


cp mongodb_exporter/mongodb_exporter /usr/local/sbin/
cp node_exporter/node_exporter-1.0.1.linux-amd64/node_exporter /usr/local/sbin/

cat <<-EOF > /etc/systemd/system/mongodb_exporter.service
[Unit]
Description=mongodb_exporter - MongoDB metrics exporter for Prometheus.
After=network.target

[Service]
Type=simple
User=root
Group=root
RemainAfterExit=no
Restart=on-failure
RestartSec=5s
EnvironmentFile=/etc/default/mongodb_exporter
ExecStart=/usr/local/sbin/mongodb_exporter  


[Install]
WantedBy=multi-user.target
EOF


cat <<-EOF > /etc/default/mongodb_exporter
MONGODB_URI="mongodb://localhost/admin"
EOF


cat <<-EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=node_exporter - Node Exporter for Prometheus.
After=network.target

[Service]
User=root
ExecStart=/usr/local/sbin/node_exporter


[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable mongodb_exporter node_exporter
systemctl start mongodb_exporter node_exporter
