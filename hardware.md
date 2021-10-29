# Hardware Overview

## CM4, IO Board, SATA Controler

The main electronic components for the NAS are:
* Compute Module CM4 (16GB eMMC, 8GB RAM, no WiFi),
* Compute Module IO board
* SATA PCIe controller

We use the CM4 and the CM IO board here, because it has PCIe interface to connect SATA hard disks instead of using USB3 to SATA controllers. So we can do stuff like RAID systems.

The SATA controller is a 1 PCIe lane controler with a Marvell 88se9215 controller. This one runs out-of-the-box on Raspberry Pi.

[CM4 + IO board](./Images/cm4-io-board-top.jpg)

[SATA controller](./Images/sata-controller.jpg)

## Power supply

The parts for the power supply are:
* 12V 7.5A power brick
* 5V 5A DCDC module
* power cable from a dead PC power supply with SATA, floppy connector

[12V powerbrick](./Images/power-brick.jpg)

[5V powerbrick](./Images/power-module.jpg)

[Power cable](./Images/power-cables.jpg)


## Front panel

The front panel is self made board on perf board. 

Front panel parts used:
* 1.5'' OLED display
* 2 x Buttons
* 1 red LED
* 1 green LED
* 40 pin Raspberry Pi connector

[OLED](./Images/oled.jpg)

[Panel](./Images/nas-panel.jpg)

## Housing, 3D printed parts

The housing is a recycled shuttle PC cube housing plus some 3D printed parts 

[Shuttle](./Images/shuttle.jpg)

[Front](./Images/nas-front2.jpg)

[Back](./Images/nas-back.jpg)
