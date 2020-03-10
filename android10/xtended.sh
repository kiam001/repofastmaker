touch PROZESSRUNNING
mkdir xtended
cd xtended
repo init -u https://github.com/Project-Xtended/manifest.git -b r31
git clone https://github.com/kiam001/Xtended_.repo_local_manifests .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
. build/envsetup.sh
lunch xtended_cedric-userdebug
make xtended -j4
scp /home/maik/build/xtended/out/target/product/cedric/Xtended-cedric-UNOFFICIAL-* "kiam001@frs.sourceforge.net:/home/frs/project/kiam001-build-roms/Device\ Cedric\ \(Moto\ G5\)/android10"
cd ../
rm -rf xtended
rm PROZESSRUNNING
echo done
