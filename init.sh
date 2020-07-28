#loads the content of the submodules, adds the layers and copies local.conf
git submodule update --init
source oe-init-build-env
bitbake-layers add-layer "../meta-rauc"
bitbake-layers add-layer "../meta-goldi"
bitbake-layers add-layer "../meta-raspberrypi"
bitbake-layers add-layer "../meta-openembedded/meta-oe"
bitbake-layers add-layer "../meta-openembedded/meta-python"
bitbake-layers add-layer "../meta-openembedded/meta-filesystems"
cp ../local.conf conf/
