#!/bin/bash

for i in "$@"

do
	# print link of WAF
	echo "WAF: $i"

	# get file count
    count=$(wget -qO - "$i" | grep '.*\.xml' | wc -l)
    echo "File count: $count"

    # get file sizes
	echo "Calculating file sizes..."
	wget -q "$i"
	filesizes=0
	while read l; do
		filesize=$(grep -oP '[0-9]+(?=[K])' <<< "$l")
		((filesizes+=filesize))
	done <index.html
	rm index.html
	echo "Combined file sizes: approx. $(($filesizes/1000)) MB"
	
    # print blank line between WAFs if more than one
	echo
done