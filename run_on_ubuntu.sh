echo "Install clipboard persistance"
sudo apt-get install parcellite

echo "Build and install vim with clipboard support"
#https://stackoverflow.com/questions/11416069/compile-vim-with-clipboard-and-xterm
git clone git@github.com:vim/vim.git
cd vim

sudo apt install libx11-dev libxtst-dev libxt-dev libsm-dev libxpm-dev

./configure --enable-python3interp=dynamic --prefix=$HOME/.local --enable-rubyinterp=dynamic --enable-gtk2-check --enable-gnome-check --with-features=huge --with-x

make install

echo "Checking for clip"
./src/vim ---version | grep clip
