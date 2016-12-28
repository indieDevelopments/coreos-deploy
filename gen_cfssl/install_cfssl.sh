#!/bin/bash
mkdir -p ~/bin
export PATH=$PATH:~/bin

curl -s -L -o ~/bin/cfssl https://pkg.cfssl.org/R1.1/cfssl_linux-amd64
curl -s -L -o ~/bin/cfssljson https://pkg.cfssl.org/R1.1/cfssljson_linux-amd64
chmod +x ~/bin/cfssl*

