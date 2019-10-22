git clone https://github.com/kiam001/android_device_motorola_cedric -b corona device/motorola/cedric
git clone https://github.com/kiam001/android_vendor_motorola_cedric vendor/motorola/cedric
git clone https://github.com/mvaisakh/eva_kernel/ -b eva-rel/eas+/3.18 kernel/motorola/msm8937
git clone https://github.com/kiam001/packages_resources_MotoActions packages/resources/MotoActions
echo "What is rom are you building this is for .mk files so see what is required:"
read rom
devicedir=device/motorola/cedric
cd $devicedir
mv cos_cedric".mk" $rom"_"cedric".mk"
newmk=$rom"_"cedric".mk"
sed -i -e 's/cos/'$rom/g $newmk
sed -i -e 's/cos/'$rom/g vendorsetup.sh
sed -i -e 's/cos/'$rom/g AndroidProducts.mk
cd "$OLDPWD"
echo Ready to Build
