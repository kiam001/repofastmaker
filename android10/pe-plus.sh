#!/bin/bash
touch PROCESSRUNNING
mkdir -p builds
mkdir pe-plus
cd pe-plus
repo init -u https://github.com/pe-wip/manifest -b ten-plus --depth=1
git clone https://github.com/kiam001/PixelExperience_.repo_local_manifests .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
. build/envsetup.sh
lunch aosp_cedric-userdebug
mka bacon -j$(nproc --all)
if [ "$upload" == "yes" ]
then
scp out/target/product/cedric/PixelExperience* "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Cedric\ \(Moto\ G5\)/android10"
fi
cp out/target/product/cedric/PixelExperience* ../builds
cd ../
rm -rf pe-plus
rm PROCESSRUNNING
echo done
