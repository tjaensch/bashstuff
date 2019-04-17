#!/bin/bash

# find the Geoportal URL from all the collection files in Silver Spring that don't have an accession file name with just numbers but characters, like e.g. "GHRSST..."
# will need to be modified to be run somewhere other than Silver Spring

find /nodc/web/data.nodc/htdocs/nodc/archive/metadata/approved/iso -name '[^0-9]*.xml' > input.txt

while read line; do
	echo $line
	echo -e "$line , $(grep -rw $line -e 'https://www.nodc.noaa.gov/search/granule/rest/find/document?searchText')" >> file.csv
done <input.txt
