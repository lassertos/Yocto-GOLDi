#loads the content of the submodules, adds the layers and copies local.conf
cd meta-goldi/recipes-core/bundles && mkdir files && cd files && openssl req -x509 -newkey rsa:4096 -keyout ca.key.pem -out ca.cert.pem -days 365 -nodes && cp ca.cert.pem ../../rauc/files/ca.cert.pem && cd ../../../..
source oe-init-build-env
bitbake-layers add-layer "../meta-goldi"
bitbake-layers add-layer "../meta-rauc"
bitbake-layers add-layer "../meta-raspberrypi"
bitbake-layers add-layer "../meta-openembedded/meta-oe"
bitbake-layers add-layer "../meta-openembedded/meta-python"
bitbake-layers add-layer "../meta-microcontroller"
bitbake-layers add-layer "../meta-openembedded/meta-filesystems"
bitbake rauc-native
cp ../meta-goldi/recipes-core/rauc/files/ca.cert.pem tmp/deploy/tools
cp ../meta-goldi/recipes-core/rauc/files/system.conf tmp/deploy/tools
