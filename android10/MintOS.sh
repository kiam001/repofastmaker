#!/bin/bash
export CCACHE_EXEC=/usr/bin/ccache
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
git config --global user.name "kiam001"
git config --global user.email "blablatupfen@gmail.com"
touch PROCESSRUNNING
mkdir -p builds
mkdir lineage-17.1
git clone git@github.com:nift4/Mint-OS.git MintOS
cd lineage-17.1
repo init -u git://github.com/LineageOS/android.git -b lineage-17.1 --depth=1
cd ../MintOS
make setup MINTOS_DIR=../lineage-17.1 MINTOS_DEVICE=cedric
make prepare
cd ../lineage-17.1
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
cd ../MintOS
git config apply.whitespace nowarn
make patch
cd ../lineage-17.1
. build/envsetup.sh
lunch lineage_cedric-userdebug
brunch cedric
scp out/target/product/cedric/lineage-17.1*.zip "kiam001@frs.sourceforge.net:/home/frs/project/mint-os-project/"
cp out/target/product/cedric/lineage-17.1*.zip out/target/product/cedric/ota_metadata ../builds
cd ../MintOS
git pull
../lineage-17.1/build/make/tools/releasetools/ota_from_target_files  --block -i ../update/target_files_intermediates/lineage_cedric-target_files-eng.kiam001.zip ../lineage-17.1/out/target/product/cedric/obj/PACKAGING/target_files_intermediates/lineage_cedric-target_files-eng.kiam001.zip incremental_$(date +"%Y_%m_%d_%I_%M_%p").zip
scp incremental_*.zip kiam001@frs.sourceforge.net:/home/frs/project/mint-os-project/
cp -r ../lineage-17.1/out/target/product/cedric/obj/PACKAGING/target_files_intermediates/ ../update
./mkota-wrapper.sh incremental_*.zip ../lineage-17.1/out/target/product/cedric/ota_metadata cedric `(ls incremental_*.zip)`
git push
rm incremental_*.zip
scp ../lineage-17.1/out/target/product/cedric/obj/PACKAGING/target_files_intermediates/lineage_cedric-target_files-eng.kiam001.zip "kiam001@frs.sourceforge.net:/home/frs/project/mint-os-project/incremental/dontFLASH/"
make genota
git push
cd ..
rm -rf lineage-17.1
rm -rf MintOS
rm PROCESSRUNNING
echo done
