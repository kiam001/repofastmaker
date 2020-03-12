#!/bin/bash
touch PROCESSRUNNING
mkdir -p builds
mkdir evox
cd evox
repo init -u https://github.com/Evolution-X/manifest -b ten --depth=1
git clone https://github.com/kiam001/evox_.repo_local_manifests .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
. build/envsetup.sh
lunch aosp_cedric-userdebug
mka bacon -j$(nproc --all)
if [ "$upload" == "yes" ]
then
scp out/target/product/cedric/EvolutionX* "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Cedric\ \(Moto\ G5\)/android10"
fi
cp out/target/product/cedric/EvolutionX* ../builds
cd ../
rm -rf evox
rm PROCESSRUNNING
echo done
