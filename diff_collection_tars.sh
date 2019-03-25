#!/bin/bash

tar -tf "$1" | sed 's#.*/##' > /tmp/list1.txt
tar -tf "$2" | sed 's#.*/##'  > /tmp/list2.txt

echo "Unique to $1:"
comm -23 <(sort /tmp/list1.txt) <(sort /tmp/list2.txt)

echo ''

echo "Unique to $2:"
comm -13 <(sort /tmp/list1.txt) <(sort /tmp/list2.txt)