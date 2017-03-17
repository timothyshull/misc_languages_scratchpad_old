#!/bin/bash
cd /usr/bin
sudo mkdir xcode_gcc
sudo mv {cc,gcc,c++,g++} xcode_gcc
sudo ln -s /usr/local/Cellar/gcc47/4.7.4/bin/gcc-4.7 cc
sudo ln -s /usr/local/Cellar/gcc47/4.7.4/bin/gcc-4.7 gcc
sudo ln -s /usr/local/Cellar/gcc47/4.7.4/bin/c++-4.7 c++
sudo ln -s /usr/local/Cellar/gcc47/4.7.4/bin/g++-4.7 g++
