#!/bin/bash
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
git config --global user.name "kiam001"
git config --global user.email "blablatupfen@gmail.com"
chmod a+x ~/bin/repo
touch PROCESSRUNNING
mkdir -p builds
mkdir pixysos
cd pixysos
repo init -u https://github.com/PixysOS/manifest -b ten --depth=1
git clone https://github.com/kiam001/all10_.repo_local_manifests -b pixysos .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
. build/envsetup.sh
lunch pixys_cedric-userdebug
make pixys j$(nproc --all)

scp out/target/product/cedric/PixysOS* "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Cedric\ \(Moto\ G5\)/android10"
cp out/target/product/cedric/PixysOS* ../builds
cd ../
rm -rf pixysos
rm PROCESSRUNNING
echo done
