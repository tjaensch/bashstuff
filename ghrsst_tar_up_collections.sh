#!/bin/sh
cd /nodc/web/data.nodc/htdocs/nodc/archive/metadata/test/granule/iso/ghrsst_new/
for dir in */
do
  base=$(basename "$dir")
  tar -czf "${base}.tar.gz"  "/nodc/projects/satdata/Granule_OneStop/GHRSST/xml"
done