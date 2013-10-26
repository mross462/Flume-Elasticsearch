#Install Kibana
apt-get -y install nginx git vim curl
git clone https://github.com/elasticsearch/kibana /usr/share/nginx/kibana
sed -i 's/www/kibana\/src/g' /etc/nginx/sites-available/default
service nginx restart

#Install Elasticsearch
apt-get install openjdk-7-jre-headless -y
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.5.deb
dpkg -i elasticsearch-0.90.5.deb
service elasticsearch start
