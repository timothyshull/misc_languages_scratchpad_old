#!/bin/bash
cd /usr/bin
sudo rm cc gcc c++ g++
sudo mv excode_gcc/cc .
sudo mv excode_gcc/gcc .
sudo mv excode_gcc/g++ .
sudo mv excode_gcc/c++ .
sudo rm -rf excode_gcc
