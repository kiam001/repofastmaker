git clone https://github.com/kiam001/android_device_motorola_cedric -b bootleg device/motorola/cedric
git clone https://github.com/kiam001/android_vendor_motorola_cedric vendor/motorola/cedric
git clone https://github.com/mvaisakh/eva_kernel/ -b eva-rel/eas+/3.18 kernel/motorola/msm8937
git clone https://github.com/kiam001/packages_resources_MotoActions packages/resources/MotoActions
repo init -u https://github.com/BootleggersROM/manifest.git -b pasta
repo sync -f --force-sync --no-clone-bundle -j$(nproc --all)
source build/envsetup.sh
lunch bootleg_cedric-userdebug
mka bacon -j$(nproc --all)
echo done

