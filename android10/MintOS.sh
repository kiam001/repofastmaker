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
make patch > patch.log.txt 2>&1
git add patch.log.txt
cd ../lineage-17.1
. build/envsetup.sh
lunch lineage_cedric-userdebug
brunch cedric > ../MintOS/build.log 2>&1
scp out/target/product/cedric/lineage-17.1*.zip "kiam001@frs.sourceforge.net:/home/frs/project/motog5/MintOS/"
cp out/target/product/cedric/lineage-17.1*.zip out/target/product/cedric/ota_metadata ../builds
cd ../MintOS
git add build.log
make genota
git push
cd ..
rm -rf lineage-17.1
rm -rf MintOS
rm PROCESSRUNNING
echo done
