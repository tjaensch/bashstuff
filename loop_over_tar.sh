#!/bin/bash

var=0
while read file; do
tar -xzf  testfiles/testfiles.tar.gz --to-command=cat "$file" > $var.xml
((var++))

done < <(tar tf testfiles/testfiles.tar.gz | grep xml)
