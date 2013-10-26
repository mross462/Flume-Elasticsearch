#Install Dependencies
apt-get -y install apache2 curl openjdk-7-jre libapache2-mod-wsgi python-pip python-requests

#Add Flask Application
pip install flask grequests
mkdir -p /var/www/myapp
cp /vagrant/app.wsgi /var/www/myapp/
cp /vagrant/myapp.py /var/www/myapp/
cp -pR /vagrant/app.conf /etc/apache2/sites-enabled/000-default
service apache2 restart

#Install Apache Flume
wget http://archive.cloudera.com/cdh4/one-click-install/precise/amd64/cdh4-repository_1.0_all.deb
dpkg -i cdh4-repository_1.0_all.deb
apt-get -y update
apt-get -y install flume-ng flume-ng-agent flume-ng-doc

#Install Elasticsearch jars
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.5.tar.gz
tar xfvz *.gz
cp elasticsearch-0.90.5/lib/* /usr/lib/flume-ng/lib

#Add flume user to group adm so it can read the apache logs
usermod -a -G adm flume

#Configure flume and restart the service
cp /vagrant/flume.conf /etc/flume-ng/conf/flume.conf
service flume-ng-agent restart

#Run Our Test Driver
#python /vagrant/test_script.py
