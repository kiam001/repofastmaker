#!/bin/bash
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
git config --global user.name "kiam001"
git config --global user.email "blablatupfen@gmail.com"
touch PROCESSRUNNING
mkdir -p builds
mkdir aex
cd aex
repo init --depth=1 -u git://github.com/AospExtended/manifest.git -b 10.x
git clone https://github.com/kiam001/all10_.repo_local_manifests -b aex .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
. build/envsetup.sh
lunch aosp_cedric-userdebug
mka bacon -j$(nproc --all)
scp out/target/product/cedric/AospExtended* "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Cedric\ \(Moto\ G5\)/android10"
cp out/target/product/cedric/AospExtended* ../builds
rm -rf out/target
export USE_GAPPS=true
lunch aosp_cedric-userdebug
mka bacon -j$(nproc --all)
scp out/target/product/cedric/AospExtended* "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Cedric\ \(Moto\ G5\)/android10"
cp out/target/product/cedric/AospExtended* ../builds
cd ../
rm -rf aex
rm PROCESSRUNNING
echo done
