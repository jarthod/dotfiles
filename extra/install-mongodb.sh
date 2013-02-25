sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
sudo bash -c 'echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" >> /etc/apt/sources.list.d/10gen.list'
sudo apt-get update
sudo apt-get install mongodb-10gen