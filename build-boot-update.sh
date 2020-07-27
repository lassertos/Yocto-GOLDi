source oe-init-build-env
STARTTIME=$(bitbake -e | grep DATETIME= | cut -d= -f2)
temp="${STARTTIME%\"}"
STARTTIME="${temp#\"}"
export STARTTIME
export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE STARTTIME"
bitbake core-image-minimal-goldi update-bundle
DDI=$(bitbake -e | grep DEPLOY_DIR_IMAGE= | cut -d= -f2)
temp="${DDI%\"}"
DDI="${temp#\"}"
ls $DDI | grep update-bundle-raspberrypi3-64- | xargs -I '{}' cp $DDI/{} /var/www/html/updates/update.raucb
cp -r $DDI/bcm2835-bootfiles /var/www/html/updates
cp $DDI/boot.scr /var/www/html/updates/bcm2835-bootfiles
echo bootloader-update:1 > /var/www/html/updates/update-info
rauc info /var/www/html/updates/update.raucb >> /var/www/html/updates/update-info
