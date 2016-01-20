#!/bin/bash
sudo apt-get update
sudo apt-get -qq install git g++ pkg-config build-essential automake autoconf libtool uuid-dev libboost-all-dev

echo "Done with basic pkg's install, getting to some serious job..."
echo "First thing is to install ODR-DabMux. Which is not so easy..."
echo "Lets start with ka9q-fec"
git clone https://github.com/Opendigitalradio/ka9q-fec.git
cd ka9q-fec
./bootstrap
./configure
make
sudo make install
cd ..
echo "OK my friend we are ready to install libsodium"
git clone https://github.com/jedisct1/libsodium.git
cd libsodium
./autogen.sh
./configure
make
sudo make install
cd ..
echo "Good, good. We are allmost there..."
#wget http://download.zeromq.org/zeromq-4.1.2.tar.gz
#tar -f zeromq-4.1.2.tar.gz -x
#cd zeromq-4.1.2
#./configure
#make
#sudo make install
#cd ..

#git clone https://github.com/zeromq/libzmq
#cd libzmq
#./autogen.sh
#./configure
#make
#sudo make install
#sudo ldconfig
#cd ..
echo "Now the zeromq4-x from Github"
git clone https://github.com/zeromq/zeromq4-x.git
cd zeromq4-x
./autogen.sh
./configure
make
sudo make install
sudo ldconfig
cd ..

echo"And finlally HM ODR-DabMux..."
git clone https://github.com/Opendigitalradio/ODR-DabMux
cd ODR-DabMux
./bootstrap.sh
./configure --enable-output-zeromq --enable-input-zeromq
make
sudo make install
cd ..
echo "Piece of cake... you've got your ODR-DabMUX"

echo "Now lets get to encoders..."
echo "Starting with tooLame"
#tooLame
sudo apt-get -qq install vlc libvlc-dev jack libjack-dev
git clone https://github.com/Opendigitalradio/toolame-dab.git
cd toolame-dab
make
cd ..
echo "...and after that fdk-aac-dabplus"
#fdk-aac-dabplus
sudo apt-get -qq install libasound2-dev
git clone https://github.com/Opendigitalradio/fdk-aac-dabplus.git
cd fdk-aac-dabplus
./bootstrap
./configure --enable-jack --enable-vlc
make
sudo make install
cd ..
echo "OK good for you encoders have been installed"
echo "It's time for ODR_DabMod"
#ODR-DabMod
#git clone https://github.com/FFTW/fftw3.git
#cd fftw3
#./bootstrap.sh
#./configure


#UHD
echo "Take a seat and relax, I will install UHD drivers and it will take some time"
sudo apt-get -qq install libfftw3-dev libusb-1.0-0-dev  doxygen python-docutils cmake
git clone https://github.com/Opendigitalradio/uhd.git
cd uhd/host
mkdir build
cd build
cmake ../
make
make test
sudo make install
sudo ldconfig
cd ~/

echo "Uffff... done installing UHD and all prequisits for ODR-DabMod"
echo "So now the ODR-DabMod itself"

git clone https://github.com/Opendigitalradio/ODR-DabMod
cd ODR-DabMod
./bootstrap.sh
./configure --enable-zeromq --enable-output-uhd 
make 
sudo make install

echo "Congratulations you have just installed the whole toolchain for ODR-Dab. Which does not guarantee that it will work ;D"
