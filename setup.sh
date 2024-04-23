# DNF config
echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf
echo "defaultyes=True
keepcache=True" >> /etc/dnf/dnf.conf

sudo dnf update

BASEDIR=$(dirname "$0")
echo "$BASEDIR"

sudo dnf install -y stow
stow $BASEDIR

sudo dnf install -y fish
chsh -s /usr/bin/fish


