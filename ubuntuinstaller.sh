#!/bin/bash
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
make clean
make all
if [ -e gcadapter_oc.ko ];then
	echo 'Driver compilation successfully'
	if [ ! -e /usr/lib/modules/$(uname -r)/kernel/drivers/usb/gcadapter ];then
		mkdir /usr/lib/modules/$(uname -r)/kernel/drivers/usb/gcadapter
	fi
	echo 'SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"' > /etc/udev/rules.d/51-gcadapter.rules
	echo 'Created rules.d file'
	cp ./gcadapter_oc.ko /usr/lib/modules/$(uname -r)/kernel/drivers/usb/gcadapter
	echo 'gcadapter_oc' > /usr/lib/modules-load.d/gcadapter-oc.conf
	depmod
	echo 'Autostart successfully set up'
	insmod gcadapter_oc.ko rate=1
	echo 'Driver loaded'
else
	echo 'Driver compilation failed'
fi
