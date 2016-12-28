#!/bin/bash
dir="$(dirname "$0")"
source "$dir/../bin/import_argv.sh";

awk -v core01=$core01 -v core02=$core02 -v core03=$core03 '{gsub("{CORE01_PRIVATE_IP}",core01);gsub("{CORE02_PRIVATE_IP}",core02);gsub("{CORE03_PRIVATE_IP}",core03);print}' > rules-save < _rules-save

