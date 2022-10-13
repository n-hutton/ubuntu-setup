# install terminal profile and colours
dconf load /org/gnome/terminal/legacy/profiles:/ < ./config_files/gnome-terminal-profiles.dconf

echo "Install clipboard persistance et. al."
sudo apt-get install parcellite
sudo apt install libx11-dev libxtst-dev libxt-dev libsm-dev libxpm-dev curl zip unzip tar 

# Add touchpad indicator
sudo add-apt-repository ppa:atareao/atareao
sudo apt-get update
sudo apt-get install -y touchpad-indicator

# Set up openssh server
sudo apt-get install openssh-server
sudo systemctl enable ssh --now
sudo systemctl start ssh

echo "Build and install vim with clipboard support"
#https://stackoverflow.com/questions/11416069/compile-vim-with-clipboard-and-xterm
git clone git@github.com:vim/vim.git
cd vim

./configure --enable-python3interp=dynamic --prefix=$HOME/.local --enable-rubyinterp=dynamic --enable-gtk2-check --enable-gnome-check --with-features=huge --with-x

make install

echo "Checking for clip"
./src/vim --version | grep clip

sudo cp ./src/vim /usr/local/bin
