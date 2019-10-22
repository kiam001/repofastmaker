git clone https://github.com/kiam001/android_device_motorola_cedric -b corona device/motorola/cedric
git clone https://github.com/kiam001/android_vendor_motorola_cedric vendor/motorola/cedric
git clone https://github.com/mvaisakh/eva_kernel/ -b eva-rel/eas+/3.18 kernel/motorola/msm8937
git clone https://github.com/kiam001/packages_resources_MotoActions packages/resources/MotoActions
repo init -u https://github.com/Cosmic-OS/platform_manifest.git -b corona-release
repo sync --no-tags --no-clone-bundle --force-sync -c
. build/envsetup.sh
lunch cos_cedric-userdebug
brunch cedric
echo done
