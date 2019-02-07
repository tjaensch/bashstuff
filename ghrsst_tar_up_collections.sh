#!/bin/sh
cd /nodc/projects/metadata/granule/onestop/GHRSST/
for dir in */
do
  base=$(basename "$dir")
  tar -czf "${base}.tar.gz"  "/nodc/projects/metadata/granule/onestop/GHRSST"
done