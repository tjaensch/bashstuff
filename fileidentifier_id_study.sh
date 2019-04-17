#!/bin/bash

# script to find file identifier duplicates in collection files in directories and get an overview in a CSV file
# will need to be modified to work somewhere other than the Silver Spring file system and with directories that still exist

FILES_NODC=/nodc/web/data.nodc/htdocs/nodc/archive/metadata/approved/iso/*
FILES_NCDC_NGDC=/nodc/projects/metadata/granule/onestop/collections_from_WAFs/ncdc_ngdc_collections_05222018/projects/metadata/granule/onestop/collections_from_WAFs/NCDC_WAF_collections_05222018/*

echo "file name, fileIdentifier, fileIdentifier namespace, ID, duplicate ID" > ./fileidentifier_id_study.csv

for f in $FILES_NCDC_NGDC
do
  # variables for spreadsheet
  filename=$(basename $f)
  fileidentifier="$(xml_grep 'gmd:fileIdentifier/gco:CharacterString' $f --text_only)"
  fileidentifier_namespace="${fileidentifier%%:*}"
  id="${fileidentifier#*:}"
  # check if ID string already exists in CSV file
  if grep -qw "$id" ./fileidentifier_id_study.csv
    then
      duplicate_id="yes"
    else
      duplicate_id="no"
  fi

  echo "$filename"
  echo "$filename, $fileidentifier, $fileidentifier_namespace, $id, $duplicate_id" >> ./fileidentifier_id_study.csv
done

for f in $FILES_NODC
do
  # variables for spreadsheet
  filename=$(basename $f)
  fileidentifier="$(xml_grep 'gmd:fileIdentifier/gco:CharacterString' $f --text_only)"
  fileidentifier_namespace="${fileidentifier%%:*}"
  id="${fileidentifier#*:}"
  # check if ID string already exists in CSV file
  if grep -qw "$id" ./fileidentifier_id_study.csv
    then
      duplicate_id="yes"
    else
      duplicate_id="no"
  fi

  echo "$filename"
  echo "$filename, $fileidentifier, $fileidentifier_namespace, $id, $duplicate_id" >> ./fileidentifier_id_study.csv
done