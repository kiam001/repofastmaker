#!/bin/bash
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
git config --global user.name "kiam001"
git config --global user.email "blablatupfen@gmail.com"
touch PROCESSRUNNING
mkdir -p builds
mkdir xtended
cd xtended
repo init -u https://github.com/Project-Xtended/manifest.git -b xq
git clone https://github.com/kiam001/all10_.repo_local_manifests -b xtended-offical .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
. build/envsetup.sh
lunch xtended_cedric-userdebug
make xtended -j$(nproc --all)
scp out/target/product/cedric/Xtended* "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Cedric\ \(Moto\ G5\)/android10"
cp out/target/product/cedric/Xtended* ../builds
cd ../
rm -rf xtended
rm PROCESSRUNNING
echo done
