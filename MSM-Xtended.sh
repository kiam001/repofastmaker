git clone https://github.com/kiam001/android_device_motorola_cedric -b MSM-Xtended device/motorola/cedric
git clone https://github.com/kiam001/android_vendor_motorola_cedric vendor/motorola/cedric
git clone https://github.com/kiam001/android_kernel_motorola_msm8937 kernel/motorola/msm8937
git clone https://github.com/kiam001/packages_resources_MotoActions packages/resources/MotoActions
repo init -u https://github.com/Project-Xtended/manifest.git -b xp
repo sync -f -c -j8 --force-sync --no-clone-bundle --no-tags
. build/envsetup.sh
lunch xtended_cedric-userdebug
make xtended
echo done
