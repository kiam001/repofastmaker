#!/bin/bash
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
git config --global user.name "kiam001"
git config --global user.email "blablatupfen@gmail.com"
chmod a+x ~/bin/repo
touch PROCESSRUNNING
mkdir -p builds
mkdir atom
cd atom
repo init -u https://github.com/AtomOrganization/manifest -b ten
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
git clone https://github.com/AtomOrgDevice/device_xiaomi_lavender.git -b ten-test device/xiaomi/lavender
git clone https://github.com/stormbreaker-project/kernel_xiaomi_lavender -b old-cam kernel/xiaomi/lavender
git clone https://github.com/PixelExperience-Devices/vendor_xiaomi.git vendor/xiaomi
export LOCAL_CLANG=false
. build/envsetup.sh
lunch aosp_lavender-userdebug
mka bacon -j$(nproc --all)
scp out/target/product/cedric/Atom* "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Lavender\ \(Xiaomi\ Redmi\ Note\ 7\)"
cp out/target/product/cedric/Atom* ../builds
cd ../
rm -rf atom
rm PROCESSRUNNING
echo done
