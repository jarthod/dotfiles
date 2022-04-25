curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo tee /etc/apt/trusted.gpg.d/spotify.asc
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install spotify-client


