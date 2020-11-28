#!/bin/bash

UPDATE_DEPLOY_DIR=/var/www/html/updates/

while getopts "cp" opt; do
  	case $opt in
    	c)
      		cp $2/update-bundle-CU-$3.raucb ${UPDATE_DEPLOY_DIR}
      		cp $2/image-CU-$3.wic.bz2 ${UPDATE_DEPLOY_DIR}
      		tmp/deploy/tools/rauc -c tmp/deploy/tools/system.conf info ${UPDATE_DEPLOY_DIR}update-bundle-CU-$3.raucb > ${UPDATE_DEPLOY_DIR}update-info-CU-$3
      		;;
    	p)
      		cp $2/update-bundle-PS-$3.raucb ${UPDATE_DEPLOY_DIR}
      		cp $2/image-PS-$3.wic.bz2 ${UPDATE_DEPLOY_DIR}
      		tmp/deploy/tools/rauc -c tmp/deploy/tools/system.conf info ${UPDATE_DEPLOY_DIR}update-bundle-PS-$3.raucb > ${UPDATE_DEPLOY_DIR}update-info-PS-$3
      		;;
    	\?)
      		echo "Invalid option: -$OPTARG" >&2
      		;;
  	esac
done
