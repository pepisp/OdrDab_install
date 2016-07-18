#!/bin/bash
sudo apt-get update
sudo apt-get -qq install git g++ pkg-config build-essential automake autoconf libtool uuid-dev libboost-all-dev

echo "Now the zeromq4-x from Github"
git clone https://github.com/zeromq/zeromq4-x.git
cd zeromq4-x
./autogen.sh
./configure
make
sudo make install
sudo ldconfig
cd ..

echo "OK good for you encoders have been installed"
echo "It's time for ODR_DabMod"

#UHD
echo "Take a seat and relax, I will install UHD drivers and it will take some time"
sudo apt-get -qq install libfftw3-dev libusb-1.0-0-dev  doxygen python-docutils python-mako cmake
#git clone https://github.com/Opendigitalradio/uhd.git
git clone git://github.com/EttusResearch/uhd.git		#This repo has proper GPS version
cd uhd/host
mkdir build
cd build
cmake ../
make
make test
sudo make install
sudo ldconfig
cd ~/
sudo /usr/local/lib/uhd/utils/uhd_images_downloader.py


echo "Uffff... done installing UHD and all prequisits for ODR-DabMod"
echo "So now the ODR-DabMod itself"

git clone https://github.com/Opendigitalradio/ODR-DabMod
cd ODR-DabMod
./bootstrap.sh
./configure --enable-zeromq --enable-output-uhd 
make 
sudo make install

echo "Congratulations you have just installed the whole toolchain for ODR-Dab. Which does not guarantee that it will work ;D"
