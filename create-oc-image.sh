#!/bin/sh
set -e
OPENCORE_RELEASE=0.5.9
rm -rf ./.opencore
mkdir ./.opencore
wget https://github.com/acidanthera/OpenCorePkg/releases/download/${OPENCORE_RELEASE}/OpenCore-${OPENCORE_RELEASE}-RELEASE.zip
unzip OpenCore-${OPENCORE_RELEASE}-RELEASE.zip -d .opencore/
echo "Creating build folder..."
rm -rf build
mkdir build
echo "Copying selected resources..."

cp --verbose resources/startup.nsh build/
cp --verbose resources/config.plist build/
cp --verbose resources/config-nopicker.plist build/


mkdir -p build/EFI
cp --verbose -r ./.opencore/EFI/BOOT build/EFI


mkdir -p build/EFI/OC/Kexts
cp --verbose -r resources/kexts/* build/EFI/OC/Kexts/

mkdir -p build/EFI/OC/ACPI
cp --verbose -r resources/acpi/* build/EFI/OC/ACPI/
cp --verbose ./.opencore/EFI/OC/OpenCore.efi build/EFI/OC/

mkdir -p build/EFI/OC/Drivers
cp --verbose ./.opencore/EFI/OC/Drivers/OpenCanopy.efi build/EFI/OC/Drivers/
cp --verbose ./.opencore/EFI/OC/Drivers/OpenRuntime.efi build/EFI/OC/Drivers/
cp --verbose resources/drivers/VBoxHfs.efi build/EFI/OC/Drivers/


mkdir -p build/EFI/OC/Tools
cp --verbose ./.opencore/EFI/OC/Tools/OpenShell.efi build/EFI/OC/Tools/
cp --verbose ./.opencore/EFI/OC/Tools/ResetSystem.efi build/EFI/OC/Tools/
cp --verbose -r ./.opencore/EFI/OC/Resources build/EFI/OC


echo "Copying build script..."
cp --verbose resources/opencore-image-ng.sh build/

echo "Running build..."
cd build
sudo ./opencore-image-ng.sh  --cfg config.plist --img OpenCore.qcow2
sudo ./opencore-image-ng.sh  --cfg config-nopicker.plist --img OpenCore-nopicker.qcow2  # ShowPicker disabled
mv OpenCore.qcow2 ../
mv OpenCore-nopicker.qcow2 ../
cd ..

echo "Cleaning..."
rm -rf .opencore
rm -f OpenCore-${OPENCORE_RELEASE}-RELEASE.zip
