# myconfig
If you want descriptions about each config, see Wiki(I haven't yet written).

## Directories
- init/
	- utilities to use after setup Arch Linux
- home/
	- user config and some script
- etc/
	- system config

## Note
I haven't yet tested install script.

init/ is Arch Linux specific.

I guess home/ and etc/ will work properly on almost Linux. But I'm not sure especially install script.

## Install
```bash
cd path/to/your-workspace
git clone https://github.com/h-youhei/myconfig.git
#if you prefer ssh than https
#git clone git@github.com:h-youhei/myconfig.git
cd myconfig
#this is for home/
./install.sh
#this is for etc/
sudo ./install-etc.sh
#this is for init/
sudo ./init.sh
```
If you want to install partially, write path that isn't need to "exclude" or "exclude-etc".

## Update
```
./update.sh
