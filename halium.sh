git clone https://github.com/ubports-on-cedric/android_device_motorola_cedric -b ubp-7.1  device/motorola/cedric
git clone https://github.com/ubports-on-cedric/android_vendor_motorola_cedric -b ubp-7.1 vendor/motorola/cedric
git clone https://github.com/ubports-on-cedric/android_kernel_motorola_msm8937 -b ubp-7.1 kernel/motorola/msm8937
repo init -u https://github.com/Halium/android -b halium-7.1 --depth=1
repo sync -c -j 16
source build/envsetup.sh
breakfast cedric
mka mkbootimg
mka hybris-boot
mka systemimage
echo done
