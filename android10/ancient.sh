#!/bin/bash
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
git config --global user.name "kiam001"
git config --global user.email "blablatupfen@gmail.com"
chmod a+x ~/bin/repo
touch PROCESSRUNNING
mkdir -p builds
mkdir ancient
cd ancient
repo init -u https://github.com/Ancient-Lab/manifest -b ten --depth=1
git clone https://github.com/kiam001/all10_.repo_local_manifests -b ancient .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
. build/envsetup.sh
lunch ancient_cedric-userdebug
mka bacon -j$(nproc --all)
scp out/target/product/cedric/AncientOS-*.zip "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Cedric\ \(Moto\ G5\)/android10"
cp out/target/product/cedric/Ancient* ../builds
cd ../
rm -rf ancient
rm PROCESSRUNNING
echo done
