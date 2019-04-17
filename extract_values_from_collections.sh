#!/bin/bash

# script to extract values from ISO XML files in a directory and write to CSV
# will have to be modified to run on some other dir than specified on line 6

FILES=/nodc/users/tjaensch/geoportalScraper/collections/*

echo "file name, fileIdentifier, doi, filetitle" > ../MD_Geoportal_collections_filenames_with_titles.csv

for f in $FILES
do
  # variables for spreadsheet
  filename=$(basename $f)
  fileidentifier=$(xml_grep 'gmd:fileIdentifier/gco:CharacterString' $f --text_only)
  filetitle=$(xml_grep 'gmd:citation/gmd:CI_Citation/gmd:title' $f --text_only)
  doi=$(xml_grep 'gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code' $f)

  # write to file to extract DOI from multiple XPath matches
  echo "$doi" > ../doi.txt
  # get DOI
  doi=$(grep -o "\doi:.*<" ../doi.txt)
  # remove last character from match
  doi="${doi%?}"
  # remove line breaks
  filetitle=${filetitle//$'\n'/}
  # remove commas from filetitle
  filetitle=${filetitle//,}

  echo "$filename"
  echo "$doi"
  echo "$filename, $fileidentifier, $doi, $filetitle" >> ../MD_Geoportal_collections_filenames_with_titles.csv
done

rm ../doi.txt