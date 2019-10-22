git clone https://github.com/kiam001/android_device_motorola_cedric -b havoc device/motorola/cedric
git clone https://github.com/kiam001/android_vendor_motorola_cedric vendor/motorola/cedric
git clone https://github.com/mvaisakh/eva_kernel/ -b eva-rel/eas+/3.18 kernel/motorola/msm8937
git clone https://github.com/kiam001/packages_resources_MotoActions packages/resources/MotoActions
git clone https://github.com/kiam001/android_system_qcom system/qcom
repo init -u https://github.com/Havoc-OS/android_manifest.git -b pie && repo sync -j$(nproc --all)
. build/envsetup.sh
lunch havoc_cedric-userdebug
brunch cedric
echo done
