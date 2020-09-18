#init build environment
source oe-init-build-env

#set variables according to local configuration
MACHINE=raspberrypi3
UPDATE_DEPLOY_DIR=/var/www/html/updates/

#collect starttime and deploydir location
STARTTIME=$(bitbake -e | grep DATETIME= | cut -d= -f2)
temp="${STARTTIME%\"}"
STARTTIME="${temp#\"}"
DEPLOY_DIR_IMAGE=$(bitbake -e | grep DEPLOY_DIR_IMAGE= | cut -d= -f2)
temp="${DEPLOY_DIR_IMAGE%\"}"
DEPLOY_DIR_IMAGE="${temp#\"}"

#export starttime for use with recipes
export STARTTIME
export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE STARTTIME"
bitbake core-image-minimal-goldi update-bundle-complete

#copy raucb file to deploydir and create update-info
ls $DEPLOY_DIR_IMAGE | grep update-bundle-complete-${MACHINE}- | xargs -I '{}' cp $DEPLOY_DIR_IMAGE/{} ${UPDATE_DEPLOY_DIR}update.raucb
rauc info ${UPDATE_DEPLOY_DIR}update.raucb > /var/www/html/updates/update-info
