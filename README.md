# Catalina-KVM
For those, who bored of life -- running OSX Catalina on Linux KVM (Ubuntu 20.04)

Some bits of information for successfull OS X Catalina launch (with or without dedicated passthrough GPU)

Works4Me, WiP

Lots of stuff taken from https://github.com/kholia/OSX-KVM. 

TODO: Add description

## What it does right now

1) Builds OpenCore image for booting
2) Downloads BaseImage of OS X Catalina and converts to img (raw) format
3) Holds a template for further libvirt xml customization

## What it will not do
One-button "i've got Mac" solution.
For real usage one will need valid mobo serial and valid product serial

More details can be found here: https://dortania.github.io/OpenCore-Install-Guide/


