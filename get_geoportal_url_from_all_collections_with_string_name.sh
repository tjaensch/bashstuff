#!/bin/bash

find /nodc/web/data.nodc/htdocs/nodc/archive/metadata/approved/iso -name '[^0-9]*.xml' > input.txt

while read line; do
	echo $line
	echo -e "$line , $(grep -rw $line -e 'https://www.nodc.noaa.gov/search/granule/rest/find/document?searchText')" >> file.csv
done <input.txt
