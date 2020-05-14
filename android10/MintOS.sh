#!/bin/bash
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
repo init -u git://github.com/LineageOS/android.git -b lineage-17.1
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
cp out/target/product/cedric/lineage-17.1*.zip ../builds
cd ../MintOS
git pull
make ota > device/cedric.json
git add device/cedric.json
git commit -m "Cedric: push new OTA"
git push
cd ..
rm -rf lineage-17.1
rm -rf MintOS
rm PROCESSRUNNING
echo done
