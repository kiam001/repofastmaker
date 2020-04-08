#!/bin/bash
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
git config --global user.name "kiam001"
git config --global user.email "blablatupfen@gmail.com"
touch PROCESSRUNNING
mkdir -p builds
mkdir pe-plus
cd pe-plus
repo init -u https://github.com/PixelExperience/manifest -b ten-plus
git clone https://github.com/kiam001/PixelExperience_.repo_local_manifests .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
. build/envsetup.sh
lunch aosp_cedric-userdebug
mka bacon -j$(nproc --all)
scp out/target/product/cedric/PixelExperience* "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Cedric\ \(Moto\ G5\)/android10"
cp out/target/product/cedric/PixelExperience* ../builds
cd ../
rm -rf pe-plus
rm PROCESSRUNNING
echo done
