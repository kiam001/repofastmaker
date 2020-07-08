#!/bin/bash
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
git config --global user.name "kiam001"
git config --global user.email "blablatupfen@gmail.com"
chmod a+x ~/bin/repo
touch PROCESSRUNNING
mkdir -p builds
mkdir havoc
cd havoc
repo init -u https://github.com/Havoc-OS/android_manifest.git -b ten --depth=1
git clone https://github.com/kiam001/all10_.repo_local_manifests -b havoc .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
. build/envsetup.sh
brunch cedric
scp out/target/product/cedric/Havoc* "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Cedric\ \(Moto\ G5\)/android10"
cp out/target/product/cedric/Havoc* ../builds
rm -rf out/target
export WITH_GAPPS=true
brunch cedric
scp out/target/product/cedric/Havoc* "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Cedric\ \(Moto\ G5\)/android10"
cp out/target/product/cedric/Havoc* ../builds
cd ../
rm -rf havoc
rm PROCESSRUNNING
echo done
