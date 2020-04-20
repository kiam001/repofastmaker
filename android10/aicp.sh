#!/bin/bash
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
git config --global user.name "kiam001"
git config --global user.email "blablatupfen@gmail.com"
touch PROCESSRUNNING
mkdir -p builds
mkdir aicp
cd aicp
repo init -u https://github.com/AICP/platform_manifest.git -b q10.0
git clone https://github.com/kiam001/all10_.repo_local_manifests -b aicp .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
. build/envsetup.sh
lunch aicp_cedric-userdebug
mka bacon -j$(nproc --all)
scp out/target/product/cedric/aicp* "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Cedric\ \(Moto\ G5\)/android10"
cp out/target/product/cedric/aicp* ../builds
cd ../
rm -rf aicp
rm PROCESSRUNNING
echo done
