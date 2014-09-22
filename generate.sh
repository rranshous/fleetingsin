#!/bin/bash

full_domain=$1
short_domain=$2
image=$3

# create output dir
out_dir=../${full_domain}
mkdir -p $out_dir
echo "OUTPUT TO: ${out_dir}"

# copy all files
cp -r . $out_dir

# remove git files
rm -rf $out_dir/.git

# remove generater file
rm -rf $out_dir/generate.sh

# rename service files
mv $out_dir/domain.com@.service $out_dir/${full_domain}@.service
mv $out_dir/domain.com-register@.service $out_dir/${full_domain}-register@.service

# replace all occurances of tokens
sed -i -e s/DOMAIN.COM/"${full_domain}"/g $out_dir/${full_domain}@.service
sed -i -e s/DOMAIN.COM/"${full_domain}"/g $out_dir/${full_domain}-register@.service

sed -i -e s/DOMAIN/"${short_domain}"/g $out_dir/${full_domain}@.service
sed -i -e s/DOMAIN/"${short_domain}"/g $out_dir/${full_domain}-register@.service

sed -i -e s/DOCKER_IMAGE/$(echo $image | sed -e 's/[\/&]/\\&/g')/g $out_dir/${full_domain}@.service
sed -i -e s/DOCKER_IMAGE/$(echo $image | sed -e 's/[\/&]/\\&/g')/g $out_dir/${full_domain}-register@.service
