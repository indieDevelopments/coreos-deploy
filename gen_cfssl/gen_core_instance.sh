#!/bin/bash
dir="$(dirname "$0")"
source "$dir/../bin/import_argv.sh";

awk -v name=$name -v ip=$privateip '{gsub("{CORE_NAME}",name);gsub("{CORE_PRIVATE_IP}",ip);print}' > "${name}.json" < _core.json
