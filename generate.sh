#!/bin/bash

full_domain=$1
short_domain=$2
image=$3

# create output dir
mkdir -p ${full_domain}

# copy service files
cp domain.com@.service ${full_domain}/${full_domain}@.service
cp domain.com-register@.service ${full_domain}/${full_domain}-register@.service

# replace all occurances of tokens
sed -i -e s/DOMAIN.COM/"${full_domain}"/g ${full_domain}/${full_domain}@.service
sed -i -e s/DOMAIN.COM/"${full_domain}"/g ${full_domain}/${full_domain}-register@.service

sed -i -e s/DOMAIN/"${short_domain}"/g ${full_domain}/${full_domain}@.service
sed -i -e s/DOMAIN/"${short_domain}"/g ${full_domain}/${full_domain}-register@.service

sed -i -e s/DOCKER_IMAGE/$(echo $image | sed -e 's/[\/&]/\\&/g')/g ${full_domain}/${full_domain}@.service
sed -i -e s/DOCKER_IMAGE/$(echo $image | sed -e 's/[\/&]/\\&/g')/g ${full_domain}/${full_domain}-register@.service
