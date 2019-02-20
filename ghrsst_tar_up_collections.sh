#!/bin/sh
cd /nodc/projects/metadata/granule/onestop/GHRSST/
for dir in */
do
  base=$(basename "$dir")
  tar -czvf "/nodc/projects/metadata/granule/onestop/GHRSST_tars/not_validated/${base}.tar.gz"  "$dir"
done