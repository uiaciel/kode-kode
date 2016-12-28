#!/bin/bash

find /home/*/public_html/* -name "*.php" -exec grep -l $1  {} \; > hasilcari-$1.txt

