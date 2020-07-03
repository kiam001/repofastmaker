#!/bin/bash
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
git config --global user.name "kiam001"
git config --global user.email "blablatupfen@gmail.com"
chmod a+x ~/bin/repo
touch PROCESSRUNNING
mkdir -p builds
mkdir corvus
cd corvus
repo init -u https://github.com/Corvus-ROM/android_manifest.git -b 10 --depth=1
git clone https://github.com/kiam001/all10_.repo_local_manifests -b corvus .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
. build/envsetup.sh
lunch du_cedric-userdebug
make corvus
export USE_GAPPS=true
make corvus
scp out/target/product/cedric/Corvus* "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Cedric\ \(Moto\ G5\)/android10"
cp out/target/product/cedric/Corvus* ../builds
cd ../
rm -rf corvus
rm PROCESSRUNNING
echo done
