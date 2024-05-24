#!/usr/bin/env bash

kill $(ps aux | grep 'Xcode' | awk '{print $2}')
kill $(ps aux | grep 'Simulator' | awk '{print $2}')
tuist clean
tuist install
tuist generate