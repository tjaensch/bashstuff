#!/bin/sh

# script to count files in tarballs on server dir

# array of tars in dir
arr=(/nodc/projects/metadata/granule/onestop/GHRSST_tars/valid/*)
ALL_VALIDATED_FILES=0;

for ((i=0; i<${#arr[@]}; i++))
do
  echo $(basename "${arr[$i]}");
  COUNT=$(tar -tzf "${arr[$i]}" | wc -l)
  echo $COUNT;
  ALL_VALIDATED_FILES=$(($ALL_VALIDATED_FILES + $COUNT));
done

echo $ALL_VALIDATED_FILES;