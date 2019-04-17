#!/bin/bash

# modification of tar_up_collection_wafs.sh script to work on osload-prod
# could be run as a crontab to produce the daily collection tars and validate in one step

start=$(date +%s.%N)

mkdir /onestop-local/temp_collections_not_validated/NCDC_NGDC_WAF_collections_`date +%m%d%Y`
mkdir /onestop-local/temp_collections_not_validated/NODC_WAF_collections_`date +%m%d%Y`

# get all NCDC and NGDC collection level files from various WAFs
declare -a arr=("https://www1.ncdc.noaa.gov/pub/data/metadata/published/paleo/iso/xml/"
				"https://www1.ncdc.noaa.gov/pub/data/metadata/published/geoportal/iso/xml/"
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/Collection/iso/xml/"
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/MGG/DEM/iso/xml/"
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/MGG/Geology/iso/xml/"
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/MGG/Geophysical_Models/iso/xml/"
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/MGG/Geophysics/iso/xml/"
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/MGG/Hazard_Photos/iso/xml/"
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/MGG/Hazards/iso/xml/"
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/MGG/Seismic/iso/xml/"
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/MGG/Sonar_Water_Column/iso/xml/"
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/MGG/Well_Logs/iso/xml/"
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/MGG/passive_acoustic/iso/xml/"
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/STP/DMSP/iso/xml/"
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/STP/Geomag/iso/xml/"
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/STP/Indices/iso/xml/"
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/STP/Ionosonde/iso/xml/"
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/STP/Ionosphere/iso/xml/"
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/STP/Solar/iso/xml/"
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/STP/Solar_Imagery/iso/xml/"
				"https://www1.ncdc.noaa.gov/pub/data/metadata/published/Space_Weather/iso/xml/"/
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/STP/Terrestrial/iso/xml/"
				"https://www.ncddc.noaa.gov/approved_recs/ncddc_ims/gis/ims/final_iso/"
				"https://www.ncddc.noaa.gov/oer-waf/ISO/Resolved/2003/"
				"https://www.ncddc.noaa.gov/oer-waf/ISO/Resolved/2004/"
				"https://www.ncddc.noaa.gov/oer-waf/ISO/Resolved/2005/"
				"https://www.ncddc.noaa.gov/oer-waf/ISO/Resolved/2006/"
				"https://www.ncddc.noaa.gov/oer-waf/ISO/Resolved/2007/"
				"https://www.ncddc.noaa.gov/oer-waf/ISO/Resolved/2008/"
				"https://www.ncddc.noaa.gov/oer-waf/ISO/Resolved/2009/"
				"https://www.ncddc.noaa.gov/oer-waf/ISO/Resolved/2010/"
				"https://www.ncddc.noaa.gov/oer-waf/ISO/Resolved/2011/"
				"https://www.ncddc.noaa.gov/oer-waf/ISO/Resolved/2012/"
				"https://www.ncddc.noaa.gov/oer-waf/ISO/Resolved/2013/"
				"https://www.ncddc.noaa.gov/oer-waf/ISO/Resolved/2014/"
				"https://www.ncddc.noaa.gov/oer-waf/ISO/Resolved/2015/"
				"https://www.ncddc.noaa.gov/oer-waf/ISO/Resolved/2016/"
				"https://www.ncddc.noaa.gov/oer-waf/ISO/Resolved/2017/"
				"https://www.ncddc.noaa.gov/oer-waf/ISO/Resolved/2018/"
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/STP/SEM/iso/xml/"
                )

for i in "${arr[@]}"
do
   wget -r -np -nd -A .xml -e robots=off --directory-prefix=/onestop-local/temp_collections_not_validated/NCDC_NGDC_WAF_collections_`date +%m%d%Y`/ "$i"
done

# add NCDC & NGDC collection level files to tar ball
tar -czvf /onestop-local/temp_collections_not_validated/NCDC_NGDC_WAF_collections_`date +%m%d%Y`.tar.gz /onestop-local/temp_collections_not_validated/NCDC_NGDC_WAF_collections_`date +%m%d%Y`/
# delete processing directory
rm -r /onestop-local/temp_collections_not_validated/NCDC_NGDC_WAF_collections_`date +%m%d%Y`

# get all NODC collection level files from various WAFs
declare -a arr=(
	            "https://data.nodc.noaa.gov/nodc/archive/metadata/approved/iso/"
                )

for i in "${arr[@]}"
do
   wget -r -np -nd -A .xml -e robots=off --directory-prefix=/onestop-local/temp_collections_not_validated/NODC_WAF_collections_`date +%m%d%Y`/ "$i"
done

# add NODC collection level files to tar ball
tar -czvf /onestop-local/temp_collections_not_validated/NODC_WAF_collections_`date +%m%d%Y`.tar.gz /onestop-local/temp_collections_not_validated/NODC_WAF_collections_`date +%m%d%Y`/
# delete processing directory
rm -r /onestop-local/temp_collections_not_validated/NODC_WAF_collections_`date +%m%d%Y`

# validate
java -Xmx6g -jar /onestop-local/MetadataSubmission/target/OneStopMetadataSubmission-1.0-SNAPSHOT-jar-with-dependencies.jar -i /onestop-local/temp_collections_not_validated/ -o /onestop-local/metadata/validated_collections/ -c

# change permissions
chmod 755 /onestop-local/metadata/validated_collections/valid_NCDC_NGDC_WAF_collections_`date +%m%d%Y`.tar.gz
chmod 755 /onestop-local/metadata/validated_collections/valid_NODC_WAF_collections_`date +%m%d%Y`.tar.gz
chmod 755 /onestop-local/metadata/validated_collections/invalid_NCDC_NGDC_WAF_collections_`date +%m%d%Y`.tar.gz
chmod 755 /onestop-local/metadata/validated_collections/invalid_NODC_WAF_collections_`date +%m%d%Y`.tar.gz

# delete unvalidated tars
rm /onestop-local/temp_collections_not_validated/NCDC_NGDC_WAF_collections_`date +%m%d%Y`.tar.gz
rm /onestop-local/temp_collections_not_validated/NODC_WAF_collections_`date +%m%d%Y`.tar.gz

end=$(date +%s.%N)
runtime=$(python -c "print(${end} - ${start})")

echo "Runtime was $runtime seconds."