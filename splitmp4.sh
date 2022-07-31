#!/bin/bash
BASEDIR=`pwd`
echo "Base dir: $BASEDIR"

read -p "Do you want to proceed? (yes/no) " yn
case $yn in 
	yes ) echo ok, we will proceed;;
	no ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 1;;
esac

for MP4 in `find . -type f -name "*.mp4"`; do
MP4DIR=$(echo $MP4 | sed 's/\.mp4$//')
OUTPUTNAME=$(echo $MP4DIR | awk -F / '{print $NF}')
mkdir -p $MP4DIR
ffmpeg -i $MP4 -c copy -map 0 -segment_time 8 -f segment "${MP4DIR}/${OUTPUTNAME}+%04d.mp4"
done

