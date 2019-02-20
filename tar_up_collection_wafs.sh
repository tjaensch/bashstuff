#!/bin/bash

start=$(date +%s.%N)

mkdir NCDC_WAF_collections_`date +%m%d%Y`

# get all NCDC collection level files from various WAFs
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
                )

for i in "${arr[@]}"
do
   wget -r -np -nd -A .xml -e robots=off --directory-prefix=/nodc/projects/metadata/granule/onestop/collections_from_WAFs/input_tars/NCDC_WAF_collections_`date +%m%d%Y`/ "$i"
done

# add NCDC collection level files to tar ball
tar -czvf /nodc/projects/metadata/granule/onestop/collections_from_WAFs/input_tars/NCDC_WAF_collections_`date +%m%d%Y`.tar.gz /nodc/projects/metadata/granule/onestop/collections_from_WAFs/input_tars/NCDC_WAF_collections_`date +%m%d%Y`/
# delete processing directory
rm -r /nodc/projects/metadata/granule/onestop/collections_from_WAFs/input_tars/NCDC_WAF_collections_`date +%m%d%Y`

# tar up NODC collection level files
tar -czvf /nodc/projects/metadata/granule/onestop/collections_from_WAFs/input_tars/NODC_WAF_collections_`date +%m%d%Y`.tar.gz /nodc/web/data.nodc/htdocs/nodc/archive/metadata/approved/iso/

# validate downloaded tar balls
java -Xmx6g -jar /nodc/projects/metadata/granule/onestop/collections_from_WAFs/OneStopMetadataSubmission-1.0-SNAPSHOT-jar-with-dependencies.jar -p /nodc/projects/metadata/granule/onestop/collections_from_WAFs/input_tars/ -c

# move files to Gluster
scp /nodc/projects/metadata/granule/onestop/collections_from_WAFs/valid_NCDC_WAF_collections_`date +%m%d%Y`.tar.gz thomas.jaensch@osprocess-dev.ncei.noaa.gov:/onestop/metadata/tars/
scp /nodc/projects/metadata/granule/onestop/collections_from_WAFs/valid_NODC_WAF_collections_`date +%m%d%Y`.tar.gz thomas.jaensch@osprocess-dev.ncei.noaa.gov:/onestop/metadata/tars/

# change permissions
ssh thomas.jaensch@osprocess-dev.ncei.noaa.gov chmod 755 /onestop/metadata/tars/valid_NCDC_WAF_collections_`date +%m%d%Y`.tar.gz
ssh thomas.jaensch@osprocess-dev.ncei.noaa.gov chmod 755 /onestop/metadata/tars/valid_NODC_WAF_collections_`date +%m%d%Y`.tar.gz

# delete tars
#rm /nodc/projects/metadata/granule/onestop/collections_from_WAFs/NCDC_WAF_collections_`date +%m%d%Y`.tar.gz
#rm /nodc/projects/metadata/granule/onestop/collections_from_WAFs/NODC_WAF_collections_`date +%m%d%Y`.tar.gz

end=$(date +%s.%N)
runtime=$(python -c "print(${end} - ${start})")

echo "Runtime was $runtime seconds."