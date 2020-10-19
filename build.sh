#init build environment
source oe-init-build-env

#set variables according to local configuration
MACHINE=raspberrypi3
UPDATE_DEPLOY_DIR=/var/www/html/updates/

#collect commitnumber and deploydir location
COMMITNR=$(git rev-parse HEAD)
#COMMITNR=$(bitbake -e | grep DATETIME= | cut -d= -f2 | sed 's/"//g')
temp="${COMMITNR%\"}"
STARTTIME="${temp#\"}"
DEPLOY_DIR_IMAGE=$(bitbake -e | grep DEPLOY_DIR_IMAGE= | cut -d= -f2)
temp="${DEPLOY_DIR_IMAGE%\"}"
DEPLOY_DIR_IMAGE="${temp#\"}"

#export commitnumber for use with recipes
export COMMITNR
export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE COMMITNR"
bitbake core-image-minimal-goldi update-bundle

#copy raucb file to deploydir and create update-info
ls $DEPLOY_DIR_IMAGE | grep update-bundle-${MACHINE}- | xargs -I '{}' cp $DEPLOY_DIR_IMAGE/{} ${UPDATE_DEPLOY_DIR}update.raucb
rauc info ${UPDATE_DEPLOY_DIR}update.raucb > ${UPDATE_DEPLOY_DIR}update-info
