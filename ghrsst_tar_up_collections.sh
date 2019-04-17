#!/bin/sh

# script to batch tar the GHRSST directories in Silver Spring and write them to a dir specified on line 9

cd /nodc/projects/metadata/granule/onestop/GHRSST/
for dir in */
do
  base=$(basename "$dir")
  tar -czvf "/nodc/projects/metadata/granule/onestop/GHRSST_tars/not_validated/${base}.tar.gz"  "$dir"
done