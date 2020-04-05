#!/bin/bash
repo init -u https://github.com/AtomOrganization/manifest -b ten --depth=1
git clone https://github.com/kiam001/Atom_.repo_local_manifests .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
. build/envsetup.sh
lunch aosp_cedric-userdebug
mka bacon -j$(nproc --all)
scp out/target/product/cedric/Atom* "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Cedric\ \(Moto\ G5\)/android10"
ls out/target/product/cedric/Atom*.zip > out/target/product/cedric/filename.txt
cp out/target/product/cedric/Atom* out/target/product/cedric/Atom.zip
echo done
