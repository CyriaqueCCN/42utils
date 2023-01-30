# 42utils

Utilities for 42 projects

## Rainfall

#### Install on a new computer

```sh
./dk.sh pull
./dk.sh build
```

This creates a new Docker image based on Debian latest with good tools for binexploit (gdb-peda, pwntools, strace...) along with sshpass for easy navigation between the VM's levels and the host.

#### Launch the docker container and run the connect script (e.g. for accessing the level8)

```sh
./dk.sh run
./connect.sh level8
```

### connect.sh

- Connect to any level for which you have the flag
- Automatically copies gdb-peda to the /tmp dir on the VM and aliases gdb to it for in-VM exploitation
- Can copy all the files from a level's home directory to your current directory
- Can copy any file you want to the /tmp/<levelX> folder on the VM

Don't forget to set the VM's IP at the very top of the file.  
For the script to work, your directory structure should look like this :

```
rainfall/
  |
  | - level1/
    | - flag 
    | - ...
  | - level2/
    | - flag
    | - ...
  ...
```

## Override

The above also works for override, just search and replace all the mentions of rainfall to override (or don't, it's just for display)

## Issues

Feel free to open an issue if something doesn't work. These scripts were hastily hacked together but I'll be happy to help.
