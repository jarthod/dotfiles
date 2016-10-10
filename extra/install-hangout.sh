sudo add-apt-repository ppa:nilarimogard/webupd8
sudo apt update
sudo apt install purple-hangouts pidgin-hangouts pidgin
wget https://github.com/stv0g/unicode-emoji/archive/master.zip
mkdir -p ~/.purple/smileys/
unzip -q master.zip -d ~/.purple/smileys/
rm master.zip