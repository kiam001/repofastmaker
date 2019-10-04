git clone https://github.com/kiam001/android_device_motorola_cedric -b DerpFest device/motorola/cedric
git clone https://github.com/kiam001/android_vendor_motorola_cedric vendor/motorola/cedric
git clone https://github.com/kiam001/android_kernel_motorola_msm8937 kernel/motorola/msm8937
git clone https://github.com/kiam001/packages_resources_MotoActions packages/resources/MotoActions
git clone https://github.com/kiam001/android_system_qcom system/qcom
repo init -u git://github.com/DerpFest-OP5T/platform_manifest.git -b pie
repo sync -c -j$( nproc --all ) --force-sync --no-clone-bundle --no-tags
cd device/aosip/sepolicy
git revert 486869a -n
cd ../../../
. build/envsetup.sh
lunch aosip_cedric-userdebug
mka kronic
echo done
