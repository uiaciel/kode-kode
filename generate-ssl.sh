#!/bin/bash
#Generate SSL Key anda CSR 
clear
openssl genrsa -out $1.key 2048 ; openssl req -new -sha256 -key $1.key -out $1.csr;
cat $1.csr $1.key
