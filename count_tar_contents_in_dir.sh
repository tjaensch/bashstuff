#!/bin/sh

# array of tars in dir
arr=(/nodc/projects/metadata/granule/onestop/GHRSST_tars/valid/*)
ALL_VALIDATED_FILES=0;

for ((i=0; i<${#arr[@]}; i++))
do
  echo "${arr[$i]}"
  tar -tzf "${arr[$i]}" | wc -l
  COUNT=$(tar -tzf "${arr[$i]}" | wc -l)
  ALL_VALIDATED_FILES=$(($ALL_VALIDATED_FILES + $COUNT));
done

echo ALL_VALIDATED_FILES;