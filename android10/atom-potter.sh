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
repo init -u https://github.com/AtomOrganization/manifest -b ten
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
git clone https://github.com/LineageOS/android_system_qcom.git -b lineage-17.0 system/qcom
git clone https://github.com/richieflicker/packages_resources_MotoActions -b action packages/resources/MotoActions
git clone https://github.com/ArrowOS-Devices/android_vendor_motorola_potter.git -b arrow-10.0 vendor/motorola/potter
git clone https://github.com/ArrowOS-Devices/android_kernel_motorola_potter.git -b arrow-10.0 kernel/motorola/potter
git clone https://github.com/richieflicker/android_device_motorola_potter.git -b atom device/motorola/potter
. build/envsetup.sh
lunch aosp_potter-userdebug
mka bacon -j$(nproc --all)
scp out/target/product/potter/Atom* "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Potter\ \(Moto\ G5\ Plus\)/"
cp out/target/product/potter/Atom* ../builds
cd ../
rm -rf atom
rm PROCESSRUNNING
echo done
