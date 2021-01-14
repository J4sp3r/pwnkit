# pwnkit

This is a collection of tools from Kali to run on any machine with a docker image. This tool is aimed to help during CTFs.

This tool is only tested for Linux and Mac, it might or might not work on Windows.

# Features
- Shares the folder `/share/` from the host to the container.
- Changes directory to same working directory as on host if exists.
- Appends hosts `/etc/hosts` to container `/etc/hosts`.

## Installation
1. Make sure Docker is installed.
1. Clone this repository.
1. Optional: Add extracted location to path for easy execution.
1. Run `./pwnkit` or `pwnkit`.

## Mounting a volume into pwnkit
Change the file ./pwnkit-start from  
```docker run -i -t --rm -v /challenges/:/challenges/ jasperboot/pwnkit:latest```  
to  
```docker run -i -t --rm -v [LOCAL FOLDER]:/challenges/ jasperboot/pwnkit:latest```

`pwnkit` is used to update and start the toolkit.  
`pwnkit-update` is used to update the image and git repo.  
`pwnkit-start` is used to start the toolkit. To update as well, use `pwnkit`.  
`pwnkit-build` is used to build the image from scratch and update it on the docker registry. 
`pwnkit-gdb` is used to attach to a gdb session setup in pwntools. 

## Using pwntools and gdb
1. Add the following to your pwntools script: ```context.terminal = ['/root/tools/launch-in-session.sh', 'gdb-session']```.
2. When pwntools opens a gdb session, execute `pwnkit-gdb` on your local machine to attach.
