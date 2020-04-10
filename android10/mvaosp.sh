echo "What is rom are you building this is for .mk files so see what is required:"
read rom
devicedir=device/motorola/cedric
cd $devicedir
mv aosp_cedric".mk" $rom"_"cedric".mk"
newmk=$rom"_"cedric".mk"
sed -i -e 's/aosp/'$rom/g $newmk
sed -i -e 's/aosp/'$rom/g AndroidProducts.mk
cd "$OLDPWD"
echo Ready to Build
