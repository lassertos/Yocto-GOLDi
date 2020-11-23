#!/bin/bash

#init build environment
source oe-init-build-env

#set variables according to local configuration
MACHINE=$(cat conf/local.conf | grep ^MACHINE | cut -d'=' -f 2 | xargs)

#collect commitnumber and deploydir location
COMMITNR=$(git rev-parse HEAD)
temp="${COMMITNR%\"}"
DEPLOY_DIR_IMAGE=$(bitbake -e | grep DEPLOY_DIR_IMAGE= | cut -d= -f2)
temp="${DEPLOY_DIR_IMAGE%\"}"
DEPLOY_DIR_IMAGE="${temp#\"}"

#export commitnumber for use with recipes
CONTROLUNIT="1"
export CONTROLUNIT
export COMMITNR
export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE COMMITNR CONTROLUNIT"
bitbake core-image-minimal-goldi update-bundle

sudo ../copy-output.sh -c $DEPLOY_DIR_IMAGE $MACHINE

echo "done creating and copying control unit update and image files"

CONTROLUNIT="0"
export CONTROLUNIT
export COMMITNR
export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE COMMITNR CONTROLUNIT"
bitbake core-image-minimal-goldi update-bundle

sudo ../copy-output.sh -p $DEPLOY_DIR_IMAGE $MACHINE

echo "done creating and copying physical system update and image files"
