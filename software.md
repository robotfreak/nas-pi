# Software overview

## OS installation

You will need Raspberry OS lite as operating system. A desktop version will not work. Get the latest version from the [Raspberry Pi website](https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-32-bit). 
The Installation on a Compute module differs from a standard Raspberry Pi installation. See the [CM4 documentation](https://www.raspberrypi.com/documentation/computers/compute-module.html#flashing-the-compute-module-emmc) to flash the CM4 eMMC.

You will need: 
* Raspberry Pi OS lite image
* RPiBoot Tool
* CM4 with eMMC
* CM4 IO board
* 12V power supply
* Micro USB cable
* Jumper

After installation enable SSH and login to the Raspberry Pi via network.

## OpenMediaVault installation

[OpenMediaVault](https://www.openmediavault.org/) is an open source NAS software. 
It can be installed by executing the following command:
~~~
  wget -O – https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/install | sudo bash
~~~

## Python script

The python script [nas-pi.py](./Python/nas-pi.py) can be used to control an OLED display, a button and the fan.