#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
    cp env-mac .env
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under GNU/Linux platform
    cp env-linux .env
fi