# gcadapter_oc_kmod

Kernel module for overclocking the Nintendo Wii U/Mayflash GameCube adapter.

The default overclock is from 125 Hz to 1000 Hz. Official adapters should be able to handle this but if you experience stutter or dropped inputs you can try lowering the rate to 500 Hz.

This [document](https://docs.google.com/document/d/1cQ3pbKZm_yUtcLK9ZIXyPzVbTJkvnfxKIyvuFMwzWe0/edit) by [SSBM_Arte](https://twitter.com/SSBM_Arte) has more detailed information regarding controller overclocking.

## Building

Use `make` to build gcadapter_oc.ko and `sudo insmod gcadapter_oc.ko` to load the module into the running kernel.

If you want to unload the module (revert the increased polling rate) use `sudo rmmod gcadapter_oc.ko`. You can also use `make clean` to clean up any files created by `make`.

If you get an error saying "building multiple external modules is not supported" it's because you have a space somewhere in the path to the gcadapter-oc-kmod directory.

GNU Make can't handle spaces in filenames so move the directory to a path without spaces (example: `/home/falco/My Games/gcadapter-oc-kmod` -> `/home/falco/gcadapter-oc-kmod`).

## Installing

Open your command prompt and enter you git directory. Now run `git clone https://github.com/Vaasgeet/gcadapter-oc-kmod` and `cd gcadapter-oc-kmod/`.

Running `chmod u+x ubuntuinstaller.sh` and `sudo ./ubuntuinstaller.sh` should do the job. The module will be loaded on boot and set to 1000 Hz mode.
You might need to execute `sudo ./ubuntuinstaller.sh` each time you upgrade your kernel.

A PKGBUILD is available for Arch Linux in `packaging/`. This package uses DKMS to install and auto-update the module when the kernel is updated. A configuration file is added to load the module automatically on boot.

Prepackaged versions can be found under https://github.com/hannesmann/gcadapter-oc-kmod/releases.

## Changing the polling rate

Polling rate is set according to the `bInterval` value in the USB endpoint descriptor. The value sets the polling rate in milliseconds, for example: an interval value of 4 equals 250 Hz.

You can change the rate by using the kernel parameter `gcadapter_oc.rate=n` (if installed), passing the rate to `insmod gcadapter_oc.ko rate=n` or going into `/sys/module/gcadapter_oc/parameters` and using `echo n > rate` to change the value ([video](https://asciinema.org/a/455373)).
