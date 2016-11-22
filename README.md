# myconfig
If you want descriptions about each config, see Wiki(I haven't yet written).

## Directories
- init/
	- config that is changed by tools, script that install app and setup Arch Linux
- home/
	- user config and some script
- etc/
	- system config

## Note
You can see utility script progress [here](https://github.com/h-youhei/myconfig/issues/1).

init/ is Arch Linux specific.

I guess home/ and etc/ will work properly on almost Linux. But I'm not sure especially install script.

## Requirment
- coreutils
- rsync

## Install
```bash
cd path/to/your-workspace
git clone https://github.com/h-youhei/myconfig.git
#if you prefer ssh than https
#git clone git@github.com:h-youhei/myconfig.git
cd myconfig
sudo ./install.sh
```
If you want to install partially, write path that isn't need to "exclude" or "exclude-etc".

## Script
- install.sh
	- update and initialize
- update.sh
	- sync home/ and etc/ files
- init.sh
	- for init/
- backup.sh
	- backup config that is changed by tools
