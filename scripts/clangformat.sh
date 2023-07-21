wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
echo 'deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-7 main' | sudo tee -a /etc/apt/sources.list
echo 'deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-7 main' | sudo tee -a /etc/apt/sources.list
sudo apt update
sudo apt search 'clang-format'
