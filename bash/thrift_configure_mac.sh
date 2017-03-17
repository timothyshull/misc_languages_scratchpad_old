#!/usr/bin/env bash

./configure --with-java --with-cpp --without-c_glib --without-perl --with-python --without-php --without-ruby --prefix=/usr/local/Cellar/thrift/0.9.0 CFLAGS='-g -O2 -w' CXXFLAGS='-g -O2 -w' CC=/usr/local/Cellar/gcc48/4.8.5/bin/gcc-4.8 CXX=/usr/local/Cellar/gcc48/4.8.5/bin/g++-4.8