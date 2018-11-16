#!/bin/bash

start=$(date +%s.%N)

# get all collection level files from various WAFs
declare -a arr=("https://data.nodc.noaa.gov/nodc/archive/metadata/approved/iso/"
				"https://www1.ncdc.noaa.gov/pub/data/metadata/published/paleo/iso/xml/"
				"https://www1.ncdc.noaa.gov/pub/data/metadata/published/geoportal/iso/xml/"
				"https://www1.ncdc.noaa.gov/pub/data/metadata/published/Space_Weather/iso/xml/"/
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
				"https://data.noaa.gov/waf/NOAA/NESDIS/NGDC/STP/Terrestrial/iso/xml/"
                )

NODC=0;
NCDC=0;
NGDC=0;

for i in "${arr[@]}"
do
    count=$(wget -qO - "$i" | grep '.*\.xml' | wc -l)

    if [[ "$i" == *"nodc"* ]]; then
    	NODC=$(($NODC + $count));
    	TYPE="NODC";
    fi

    if [[ "$i" == *"ncdc"* ]]; then
    	NCDC=$(($NCDC + $count));
    	TYPE="NCDC";
    fi

    if [[ "$i" == *"NGDC"* ]]; then
    	NGDC=$(($NGDC + $count));
    	TYPE="NGDC";
    fi
    
    # write to file 
    echo "$i, $count, $TYPE" >> /nodc/projects/metadata/granule/onestop/collections_from_WAFs/waf_collection_file_counts_`date +%m%d%Y`.csv
done

# write total counts to beginning of file
echo "Record count: $(($NODC + $NCDC + $NGDC)) (NODC: $NODC NCDC: $NCDC NGDC: $NGDC)" | cat - /nodc/projects/metadata/granule/onestop/collections_from_WAFs/waf_collection_file_counts_`date +%m%d%Y`.csv > temp && mv temp /nodc/projects/metadata/granule/onestop/collections_from_WAFs/waf_collection_file_counts_`date +%m%d%Y`.csv

# move file to Gluster
scp /nodc/projects/metadata/granule/onestop/collections_from_WAFs/waf_collection_file_counts_`date +%m%d%Y`.csv thomas.jaensch@osprocess-dev.ncei.noaa.gov:/onestop/metadata/tars/

# change permissions
ssh thomas.jaensch@osprocess-dev.ncei.noaa.gov chmod 755 /onestop/metadata/tars/waf_collection_file_counts_`date +%m%d%Y`.csv

# delete file after processing
rm /nodc/projects/metadata/granule/onestop/collections_from_WAFs/waf_collection_file_counts_`date +%m%d%Y`.csv

end=$(date +%s.%N)
runtime=$(python -c "print(${end} - ${start})")

echo "Runtime was $runtime seconds."