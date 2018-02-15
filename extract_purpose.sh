#!/bin/bash
FILES=/nodc/users/tjaensch/geoportalScraper/collections/*

echo "file name, fileIdentifier, purpose" > ../MD_Geoportal_collections_files_purpose.csv

for f in $FILES
do
  # variables for spreadsheet
  filename=$(basename $f)
  fileidentifier=$(xml_grep 'gmd:fileIdentifier/gco:CharacterString' $f --text_only)
  purpose=$(xml_grep '/gmi:MI_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:purpose' $f --text_only)

  # remove line breaks
  purpose=${purpose//$'\n'/}
  # remove commas from filetitle
  purpose=${purpose//,}

  echo "$filename"
  echo "$filename, $fileidentifier, $purpose" >> ../MD_Geoportal_collections_files_purpose.csv
done