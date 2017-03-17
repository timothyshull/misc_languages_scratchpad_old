#!/usr/bin/sh

# install script for linux
# setup openssl certificate
# ./sslcert.exp

# linux pre-built binaries
curl -O https://iojs.org/download/release/v2.3.0/iojs-v2.3.0-linux-x64.tar.gz

# gunzip iojs-v2.3.0-linux-x64.tar.gz
# tar -zxvf iojs-v2.3.0-linux-x64.tar
# rm iojs-v2.3.0-linux-x64.tar
# export TEST_PW=test && export TEST_USER=admin
#
# iojs-v2.3.0-linux-x64/bin/npm install
# iojs-v2.3.0-linux-x64/bin/node ./server.js

# install script for mac
./sslcert.exp
# mac pre-built binaries
curl -O https://iojs.org/dist/v2.3.0/iojs-v2.3.0-darwin-x64.tar.gz
gunzip iojs-v2.3.0-darwin-x64.tar.gz
tar -zxvf iojs-v2.3.0-darwin-x64.tar
rm iojs-v2.3.0-darwin-x64.tar
export TEST_PW=test && export TEST_USER=admin

iojs-v2.3.0-darwin-x64/bin/npm install
iojs-v2.3.0-darwin-x64/bin/node ./server.js

CURRENT=$(node -v)
VERSION=$(curl -L -s http://nodejs.org/dist/latest/ \
    | egrep -o '[0-9]+\.[0-9]+\.[0-9]+' \
    | tail -n1)
PLATFORM=darwin
ARCH=x64
PREFIX="$HOME/node-v$VERSION-$PLATFORM-$ARCH"

if test "v$VERSION" != "$CURRENT"; then
    echo "Installing node v$VERSION ..."
    mkdir -p "$PREFIX" && \
    curl -# -L http://nodejs.org/dist/v$VERSION/node-v$VERSION-$PLATFORM-$ARCH.tar.gz \
      | tar xzvf - --strip-components=1 -C "$PREFIX"
else
    echo "Latest stable version of node already installed."
fi

#!/bin/sh

case "$(uname -s)" in

   Darwin)
     echo 'Mac OS X'
     ;;

   Linux)
     echo 'Linux'
     ;;

   CYGWIN*|MINGW32*|MSYS*)
     echo 'MS Windows'
     ;;

   *)
     echo 'other OS (or missing cases for above OSs)'
     ;;
esac