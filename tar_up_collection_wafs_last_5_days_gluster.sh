#!/bin/bash

# modification of tar_up_collection_wafs.sh script to work on Gluster

start=$(date +%s.%N)

# make dir for downloading files from WAFs
mkdir ./WAF_collections_updated_last_5_days_ending_`date +%m%d%Y`

# get all collection level files from various WAFs
declare -a arr=("https://data.nodc.noaa.gov/nodc/archive/metadata/approved/iso/"
	            "https://www1.ncdc.noaa.gov/pub/data/metadata/published/paleo/iso/xml/"
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
   wget -r -np -nd -A .xml -e robots=off --directory-prefix=./WAF_collections_updated_last_5_days_ending_`date +%m%d%Y`/ "$i"
done

# delete files older than 5 days
find ./WAF_collections_updated_last_5_days_ending_`date +%m%d%Y` -mindepth 1 -mtime +5 -delete
# add collection level files to tar ball
tar -czvf ./WAF_collections_updated_last_5_days_ending_`date +%m%d%Y`.tar.gz ./WAF_collections_updated_last_5_days_ending_`date +%m%d%Y`
# delete processing directory
rm -r ./WAF_collections_updated_last_5_days_ending_`date +%m%d%Y`

end=$(date +%s.%N)
runtime=$(python -c "print(${end} - ${start})")

echo "Runtime was $runtime seconds."