git clone https://github.com/kiam001/android_device_motorola_cedric -b resurrection device/motorola/cedric
git clone https://github.com/kiam001/android_vendor_motorola_cedric vendor/motorola/cedric
git clone https://github.com/mvaisakh/eva_kernel/ -b eva-rel/eas+/3.18 kernel/motorola/msm8937
git clone https://github.com/kiam001/packages_resources_MotoActions packages/resources/MotoActions
git clone https://github.com/kiam001/android_system_qcom system/qcom
repo init -u https://github.com/ResurrectionRemix/platform_manifest.git -b pie
repo sync -f --force-sync --no-clone-bundle
. build/envsetup.sh && brunch cedric
echo done
