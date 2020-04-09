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
git clone https://github.com/kiam001/android_device_xiaomi_violet device/xiaomi/violet
git clone --depth 1 https://github.com/tesla59/hydra_kernel kernel/xiaomi/sm6150
git clone --depth 1 https://github.com/tesla59/vendor_xiaomi_violet vendor/xiaomi/violet
cd hardware/qcom-caf/sm8150
rm -rf display audio media
git clone https://github.com/danascape/hardware_qcom-caf_sm8150_media media
git clone https://github.com/danascape/hardware_qcom-caf_sm8150_audio audio
git clone https://github.com/danascape/hardware_qcom-caf_sm8150_display display
cd ../../..
cd frameworks/base
git revert 0bba05aa09ac6dc87efc045a30835fc76ef109eb --no-commit
cd ../../
cd packages/apps/Settings
git revert bac775e6765cd1cbea362dfb800642eaef106b4d --no-commit
cd ../../..
. build/envsetup.sh
lunch aosp_violet-eng
mka bacon -j$(nproc --all)
scp out/target/product/violet/Atom* "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Violet\ Redmi\ Note\ 7\ Pro"
cp out/target/product/violet/Atom* ../builds
cd ../
rm -rf atom
rm PROCESSRUNNING
echo done
