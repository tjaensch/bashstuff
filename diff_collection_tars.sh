#!/bin/bash

tar -tf "$1" | sed 's#.*/##' > /tmp/list1.txt
tar -tf "$2" | sed 's#.*/##'  > /tmp/list2.txt

{
    echo "Mutually exclusive files:"
    comm -3 <(sort /tmp/list1.txt) <(sort /tmp/list2.txt)
    echo ""

    echo "Files only in $(basename $1):"
    comm -23 <(sort /tmp/list1.txt) <(sort /tmp/list2.txt)
    echo ""

    echo "Files only in $(basename $2):"
    comm -13 <(sort /tmp/list1.txt) <(sort /tmp/list2.txt)
    echo ""

} | mail -s "diff collection tars $(basename $1) and $(basename $2)" thomas.jaensch@noaa.gov,anna.milan@noaa.gov,justin.reid@noaa.gov
