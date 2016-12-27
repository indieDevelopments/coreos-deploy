#!/bin/bash

getopt --test > /dev/null
if [[ $? -ne 4 ]]; then
    echo "I’m sorry, `getopt --test` failed in this environment."
    exit 1
fi

LONG=core01:,core02:,core03:

# -temporarily store output to be able to check for errors
# -activate advanced mode getopt quoting e.g. via “--options”
# -pass arguments only via   -- "$@"   to separate them correctly
PARSED=`getopt -o o --long $LONG -- "$@"`
if [[ $? -ne 0 ]]; then
    # e.g. $? == 1
    #  then getopt has complained about wrong arguments to stdout
    exit 2
fi
# use eval with "$PARSED" to properly handle the quoting
eval set -- "$PARSED"

# now enjoy the options in order and nicely split until we see --
while true; do
    case "$1" in
        --core01)
            c1="$2"
            shift 2
            ;;
        --core02)
            c2="$2"
            shift 2
            ;;
        --core03)
            c3="$2"
            shift 2
            ;;
	-o)
	o=true
	shift 1;;
        --)
            shift
            break
            ;;
        *)
            echo "Programming error"
            exit 3
            ;;
    esac
done

# handle non-option arguments
#if [[ $# -ne 1 ]]; then
#    echo "$0: A single input file is required."
#    exit 4
#fi

awk -v core01=$c1 -v core02=$c2 -v core03=$c3 '{gsub("{CORE01_PRIVATE_IP}",core01);gsub("{CORE02_PRIVATE_IP}",core02);gsub("{CORE03_PRIVATE_IP}",core03);print}' > rules-save < _rules-save
