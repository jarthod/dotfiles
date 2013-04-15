VERSION="1.9.3-p392"
curl https://raw.github.com/gist/4646193/2-$VERSION-patched.sh > /tmp/$VERSION
rbenv install /tmp/$VERSION
