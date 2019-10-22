git clone https://github.com/kiam001/android_device_motorola_cedric -b pie-plus device/motorola/cedric
git clone https://github.com/kiam001/android_vendor_motorola_cedric vendor/motorola/cedric
git clone https://github.com/mvaisakh/eva_kernel/ -b eva-rel/eas+/3.18 kernel/motorola/msm8937
git clone https://github.com/kiam001/packages_resources_MotoActions packages/resources/MotoActions
repo init -u https://github.com/PixelExperience/manifest -b pie-plus
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags -j$(nproc --all)
. build/envsetup.sh
device=cedric
lunch aosp_$device-userdebug
mka bacon -j$(nproc --all)
echo done
