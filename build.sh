source oe-init-build-env
STARTTIME=$(bitbake -e | grep DATETIME= | cut -d= -f2)
temp="${STARTTIME%\"}"
STARTTIME="${temp#\"}"
export STARTTIME
export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE STARTTIME"
echo $(bitbake -e | grep DATETIME= | cut -d= -f2)
echo $(bitbake -e | grep STARTTIME= | cut -d= -f2)
#bitbake core-image-minimal-goldi update-bundle
DDI=$(bitbake -e | grep DEPLOY_DIR_IMAGE= | cut -d= -f2)
temp="${DDI%\"}"
DDI="${temp#\"}"
ls $DDI | grep update-bundle-raspberrypi4- | xargs -I '{}' cp $DDI/{} /var/www/html/updates/update.raucb
rauc info /var/www/html/updates/update.raucb > /var/www/html/updates/update-info
