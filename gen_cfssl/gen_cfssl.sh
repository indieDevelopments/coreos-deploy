#!/bin/bash
dir="$(dirname "$0")"
source "$dir/../bin/import_argv.sh";

cfssl gencert -initca ca-csr.json | cfssljson -bare ca -
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=client-server "$name.json" | cfssljson -bare coreos
chmod 0644 coreos-key.pem
scp ca.pem coreos-key.pem coreos.pem "core@$ip":

