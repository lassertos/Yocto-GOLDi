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

#copy raucb file to deploydir and create update-info
ls $DEPLOY_DIR_IMAGE | grep update-bundle-complete-${MACHINE}- | xargs -I '{}' cp $DEPLOY_DIR_IMAGE/{} ${UPDATE_DEPLOY_DIR}update.raucb
tmp/deploy/tools/rauc -c tmp/deploy/tools/system.conf info ${UPDATE_DEPLOY_DIR}update.raucb > ${UPDATE_DEPLOY_DIR}update-info

