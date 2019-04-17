#!/bin/bash

# self explanatory; runs over ISO XML files in a directory specified on line 5

FILES=/nodc/users/tjaensch/geoportalScraper/collections/*

for f in $FILES
do
  filename=$(basename $f)
  fileidentifier=$(xml_grep 'gmd:fileIdentifier/gco:CharacterString' $f --text_only)
  # remove colon from file name
  fileidentifier=${fileidentifier//:}
  # rename file with file identifier w/ colon removed
  mv $f /nodc/users/tjaensch/geoportalScraper/collections/$fileidentifier.xml
  
  echo "$filename $fileidentifier"
done