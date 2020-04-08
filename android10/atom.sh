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
repo init -u https://github.com/AtomOrganization/manifest -b ten --depth=1
git clone https://github.com/AtomOrganization/cerdic_official .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
. build/envsetup.sh
lunch aosp_cedric-userdebug
mka bacon -j$(nproc --all)
scp out/target/product/cedric/Atom* "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Cedric\ \(Moto\ G5\)/android10"
cp out/target/product/cedric/Atom* ../builds
cd ../
rm -rf atom
rm PROCESSRUNNING
echo done
