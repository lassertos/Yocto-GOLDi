#!/bin/bash

#init build environment
source oe-init-build-env

#set variables according to local configuration
MACHINE=raspberrypi3
UPDATE_DEPLOY_DIR=/var/www/html/updates/

#collect commitnumber and deploydir location
COMMITNR=$(git rev-parse HEAD)
temp="${COMMITNR%\"}"
DEPLOY_DIR_IMAGE=$(bitbake -e | grep DEPLOY_DIR_IMAGE= | cut -d= -f2)
temp="${DEPLOY_DIR_IMAGE%\"}"
DEPLOY_DIR_IMAGE="${temp#\"}"

#export commitnumber for use with recipes
export COMMITNR
export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE COMMITNR"
bitbake core-image-minimal-goldi update-bundle-complete

cd ..
sudo ./copy-output-boot-update.sh
