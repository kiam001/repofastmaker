#!/bin/bash
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
git config --global user.name "kiam001"
git config --global user.email "blablatupfen@gmail.com"
chmod a+x ~/bin/repo
touch PROCESSRUNNING
mkdir -p builds
mkdir cygnus
cd cygnus
repo init -u https://github.com/cygnus-rom/manifest.git -b caf-ten
git clone https://github.com/kiam001/cygnus_.repo_local_manifests .repo/local_manifests
repo sync -j$(nproc --all) --force-sync --no-tags --no-clone-bundle --prune --optimized-fetch
repo forall -c git lfs pull
. build/envsetup.sh
lunch cygnus_cedric-userdebug
mka cygnus
scp out/target/product/cedric/Cygnus* "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Cedric\ \(Moto\ G5\)/android10"
cp out/target/product/cedric/Cygnus* ../builds
cd ../
#rm -rf cygnus
rm PROCESSRUNNING
echo done

