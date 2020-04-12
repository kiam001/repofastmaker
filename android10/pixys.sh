#!/bin/bash
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
git config --global user.name "kiam001"
git config --global user.email "blablatupfen@gmail.com"
chmod a+x ~/bin/repo
touch PROCESSRUNNING
mkdir -p builds
mkdir pixys
cd pixys
repo init -u https://github.com/PixysOS/manifest -b ten
git clone https://github.com/kiam001/PixysOS_.repo_local_manifests .repo/local_manifests
repo sync  --force-sync --current-branch --no-tags --no-clone-bundle --optimized-fetch --prune -j$(nproc --all)
. build/envsetup.sh
lunch pixys_cedric-userdebug
make pixys -j$(nproc --all)
scp out/target/product/cedric/Pixys* "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Cedric\ \(Moto\ G5\)/android10"
cp out/target/product/cedric/Pixys* ../builds
cd ../
rm -rf pixys
rm PROCESSRUNNING
echo done
