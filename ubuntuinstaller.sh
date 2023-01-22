#!/bin/bash
make clean
make all
if [ -e gcadapter_oc.ko ];then
	if [ ! -e /usr/lib/modules/$(uname -r)/kernel/drivers/usb/gcadapter ];then
		mkdir /usr/lib/modules/$(uname -r)/kernel/drivers/usb/gcadapter
	fi
	cp ./gcadapter_oc.ko /usr/lib/modules/$(uname -r)/kernel/drivers/usb/gcadapter
	echo 'gcadapter_oc' > /usr/lib/modules-load.d/gcadapter-oc.conf
	depmod
	echo 'Autostart successfully set up!'
	insmod gcadapter_oc.ko rate=1
	echo 'Driver loaded'
fi
