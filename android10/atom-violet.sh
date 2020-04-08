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
git clone https://github.com/Descendant-Devices/android_device_xiaomi_violet device/xiaomi/violet
cd device/xiaomi/violet
git revert 7cf197aa8fdf79fd0820b6ae713e76f35ea2f139 --no-commit
git revert 69a447ccfdb8a824fd0d37a4ebbfddf767bcca0d --no-commit
git revert 624eed9fccaad159d7d9418db49cff060af1bbd9 --no-commit
cd ../../..
git clone --depth 1 https://github.com/tesla59/hydra_kernel kernel/xiaomi/sm6150
git clone --depth 1 https://github.com/tesla59/vendor_xiaomi_violet vendor/xiaomi/violet
cd hardware/qcom-caf/sm8150
rm -rf display audio media
git clone https://github.com/danascape/hardware_qcom-caf_sm8150_media media
git clone https://github.com/danascape/hardware_qcom-caf_sm8150_audio audio
git clone https://github.com/danascape/hardware_qcom-caf_sm8150_display display
cd ../../..
. build/envsetup.sh
lunch aosp_violet-userdebug
mka bacon -j$(nproc --all)
scp out/target/product/violet/Atom* "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Violet\ Redmi\ Note\ 7\ Pro"
cp out/target/product/violet/Atom* ../builds
cd ../
rm -rf atom
rm PROCESSRUNNING
echo done
