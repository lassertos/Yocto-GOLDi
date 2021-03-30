#!/bin/bash

UPDATE_DEPLOY_DIR=/var/www/html/updates/

while getopts "cp" opt; do
  	case $opt in
    	c)
      		cp $2/casync-update-bundle-CU-$3.raucb ${UPDATE_DEPLOY_DIR}
      		cp $2/image-CU-$3.wic.bz2 ${UPDATE_DEPLOY_DIR}
      		rsync -a --delete-after $2/casync-update-bundle-CU-$3.castr ${UPDATE_DEPLOY_DIR}
      		;;
    	p)
      		cp $2/casync-update-bundle-PS-$3.raucb ${UPDATE_DEPLOY_DIR}
      		cp $2/image-PS-$3.wic.bz2 ${UPDATE_DEPLOY_DIR}
      		rsync -a --delete-after $2/casync-update-bundle-PS-$3.castr ${UPDATE_DEPLOY_DIR}
      		;;
    	\?)
      		echo "Invalid option: -$OPTARG" >&2
      		;;
  	esac
done
