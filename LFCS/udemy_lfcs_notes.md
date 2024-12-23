# LFCS UDEMY COURSE

## Essential Commands

### 14. Create, delete, copy and move files

```Bash
# previous folder
cd -

# recursive copy
cp -r

# ssh version
ssh -V

# ssh verbose mode
ssh -v

# To get inode numbers
stat
```

### 15,16. create and manage Hard ans Soft Links

```Bash
# Hard link
# We can delete a file for a user, it will be accessible fo another
# hard link only on same file-system, file to file NOT FOLDER
ln path_to_target_file path_to_link_file

## symbolic link, on files and folders too and accessible on different file-system.
## readlink if link name is too long
ln -s target link
```

### 19. SUID, SGID ans Sticky Bit

```Bash
# SUID
# the program will be executed with the same rights as the prorietary and not who's execute 
# chmod 4xxx :
-rwSrw-r-- => suid but not executable
-rwsrw-r-- => suid and executable

# GUID
# idem for suid but for groupes (folders and files)

# Sticky bit

# Only owner,directory owner and root can modifiy and delete files.
chmod +t
```

### 20,21. Search for files, compare and manipulate file contents

```Bash
# Find

find . -perm /2000
find <path> <parameters>
find -name
find -size +10M
find -mmin => modified minute
find -iname => search by name non sensitive
find /home/bob -size 213k -o -perm 402
sudo find /home/bob/ -name cats.txt -exec cp {} /opt/ \;

# Compare and manipulate file content

cat
tac # view reverse - inverse cat

tail # last 10 lignes
tail -n 20

head

sed
sed 's/canda/canada/g' userinfo.txt => preview changes
sed -i 's/canda/canada/g' userinfo.txt => store changes (--in-place)

cut -d ' ' -f 1 userinfo.txt 
=> -d delimiter ' '
=> -f 1 fields ti extract

sort # trier en ordre, pui passer l'uniq
uniq # garde les contents uniques cote a cote

diff  # compare files
diff -c file1 file2
diff -y file1 file 2 # sdiff file1 file 2

less
/ # to search
n # next
  # shift +n previous
  # - key sensitive search

more

vim
/ # search
/ # senitive search\c
: # go to line
yy # copy
p # paste
dd # cut

grep 'password' /etc/ssh/sshd_config
grep -i 'password' /etc/ssh/sshd_config # lower or uppercase
grep -r # recursive
sudo grep -ri --color 'password' /etc/ # color option for sudo search
grep -v # don't contain
grep -wi 'password' # the exact word, lower or uppercase
grep -o # only matching
```

### 25. Ananlyze text using basic regular expressions

```Bash
# Regular expressions
^ # '^#' => start with, combined with grep -v retire les commentaires
$ # '7$' => at the end, -w the end and only one char.
. # grep -r 'c.t' /etc/ => one char.
* # => previous char one or more times
\ # escape char.
+ # 0+ , 0, 00, 000

{}
?
|
[]
()
[^]

```

### 28,29. Archive, Back UP, unpack, compress / Uncompress Files

```Shell
# tar = tape Archive
# List content of tar Archive
tar --list --file arhive.tar
tar -tf archive.tar
tar tf archive.tar

# Create Archive
tar --create --file arhive.tar file1
tar --create --file arhive.tar pictures/ # for un entire folder
tar cf archive.tar file1

# Add a file to archive
tar --append --file archive.atr file2
tar rf arhive.tar file2

# Extract archive
# List before extract to check what is inside 
tar --extract --file archive.tar
tar xf archive.tar

# Use sudo to hold file permissions
tar --extract --file arhive.tar --directory /tmp/
tar xf archive.tar -C /tmp/

# gz, bz, xz
gzip file1
gunzip file1.gz

bzip2 file2
bunzip file2.bz2

xz file3
unxz file3.xz

# --keep, to keep original file

# zip
zip arhive file1
zip -r arhive.zip Pictures/
unzip arhive.zip

# tar and compress
tar --create --gzip --file arhive.tar.gz file1
tar czf arhive.tar.gz file1

tar --create --bzip2 --file arhive.tar.bz2 file1
tar cjf arhive.tar.bz2 file1

tar --create --xz --file arhive.tar.xz file1
tar cJf arhive.tar.xz file1

tar --create --gzip --file arhive.tar.gz file1
tar czf arhive.tar.gz file1
tar --create --autocompress --file archiv.tar.gz file1
```

### 30. Backup to a remote system

```Bash
# Backup with rsync
# When we execute, it's continue from the last sync
# -a (archive) means it store persmissions etc.
# sync on ssh connection
rsync -a Pictures/ zoltan@9.9.9.9:/home/zoltan/Pictures

# Backup un entire disk or partition
# Diks imaging
# Should unmount disk before
sudo dd if=/dev/vda of=diskimage.raw bs=1M status=progress
sudo dd if=diskimage.raw of=/dev/vda  bs=1M status=progress
```

### 31. Input, output redirection, pipelineing

```Bash
# Input, output redirection
> # redirect output
>> # append output

# < stdin
# 1> stdout
# 2> stderr

grep -r '^The' /etc/ 2>/dev/null
grep -r '^The' /etc/ 1>output.txt 2>errors.txt
grep -r '^The' /etc/ 1>>output.txt 2>>errors.txt

grep -r '^The' /etc/ 1>output.txt 2>&1

sort <<EOF
.......
.......
.......
>EOF

# Pipeing
grep -v '^#' /etc/login.defs | sort | column -t

```

### 33-36. SSL Certificates, GIT

```Bash
# https://www.digitalocean.com/community/tutorials/openssl-essentials-working-with-ssl-certificates-private-keys-and-csrs
# Create private .key and .csr request
openssl req \
       -newkey rsa:2048 -keyout domain.key \
       -out domain.csr

# Create self-signed certificate
openssl req \
       -newkey rsa:2048 -nodes -keyout domain.key \
       -x509 -days 365 -out domain.crt

# Verify csr entries
openssl req -text -noout -verify -in domain.csr

# Verify certificate entries
openssl x509 -text -noout -in domain.crt

# Delete GIT branches
git branch -d <branchname>

# Commits
git log
git log --raw

# Merge
git checkout master
git merge documentation
```

## Operations Deployment

### 38. Boot, Reboot, Shutdown

```Shell
sudo systemctl reboot
sudo systemctl shutdown

sudo systemctl reboot --force
sudo systemctl poweroff --force

sudo shutdown 02:00
sudo shutdown +15
sudo shutdown -r 02:00 # reboot option
sudo shutdown -r +1 'Wall message'

sudo systemctl get-default # graphical.target at boot
sudo systemctl set-default multi-user.target # don't start grpahical interface
sudo systemctl isolate graphical.target
emergency.target
rescue.target

# Modify grub parameters
/boot/default/grub

# Generate new configuration file
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# Change grube default timeout
/boot/default/grub
/etc/default/grub ==> update-grub

# Identify disk
lsblk
# Install grub
sudo grub-install /dev/sda > /home/bob/grub/txt 2>&1
# Generate grub configuration
sudo update-grub # alternatively sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo reboot
```

### 41. Scripting ti automate system maintenance tasks

```Shell
# Scripts
#!/bin/bash
date >> /tmp/script.log

if test -f /tmp/archive.tar.gz; then
  mv /tmp/archive.tar.gz /tmp/archive.tar.gz.OLD
  tar acf /tmp/archive.tar.gz /etc/apt/
else
  tar acf /tmp/archive.tar.gz /etc/apt/
fi

# Return codes in BASH
 0 ==> OK
 >0 ==> NOK
```

### 42. Manage Startup Process ans Services

```Bash
# Show all systemd unit services
systemctl list-units --type service --all

# Afficher contenu systemd services
systemctl cat service.target

# Modify sytemd services
systemctl edit service.target
systemctl edit -full service.target

# Undo modifications
systemctl revert service.target

# Service manipulation
systemctl start/stop/status/restart/reload/reload-or-restart service.target
systemctl enable/disable --now service.target
```

### 43. Create systemd services

```Bash
# systemd-cat - Connect a pipeline or program's output with the journal
#!/bin/bash
echo "MyApp started" | systemd-cat -t MyApp -p info
sleep 5
echo "MyApp crached" | systemd-cat -t MyApp -p error

# Examples
ls /lib/systemd/system

[Unit]
[Service]
[Install]

systemctl daemon-reload # after each modification
journalctl -f # follow mode
```

### 44. LAB

```Bash
#!/bin/bash
systemctl is-enabled sshd.service
```

### 45. Diagnose and manage processes

```Bash
# Show all processes
ps aux
[kernel processes]
ps u -U jeremy
pidof firefox # determine PID number

# Process grep
pgrep -a bash

# Show all process belongs to PID
lsof -p <PID>

# nice prioriries
nice -n 11 bash
ps fax -U jeremy
ps lax -U jeremy
renice 7 <PID> # only root can routless niceness

# SIGNALS
# Lis signal options 
kill -l

kill -1 <SIGHUB> # allow to recharge a process
kill -9 <SIGKILL> # allow to kill a process
kill -15 <SIGTERM> # allow to terminate a process

# JOBS
# Start program in the background
sleep 300 &
jobs # show all jobs
fg # show in foreground the app in the backgroud
bg # show in backgroud the app in the foreground
```

### 46. Locate and analyse system file logs

```Bash
# rsyslog = rocket-fast system for log processing
ls /var/log

sudo grep -r 'ssh' /var/log
sudo grep -r 'ssh' /var/syslog

# Watch login files in follow mode
tail -F /var/log/auth.log

# journalctl to collect logs
journalctl -u ssh.service
journalctl -e # go to the end
journalctl -f # follow mode
journalctl -p err # priority; alert, crit, debug, emerg, err, info, notice, warning

# Filter with grep expression
journalctl -p info -g '^b'   

# Filter since to until
journalctl -S 02:00 -U 03:00
journalctl -S '2024-03-11 02:00:12'

journalctl -b 0 # current boot
journalctl -b -1 # last boot

# See who logged in
last
lastlog
```

### 47. LAB manage process and analyze logs

```Bash
# Show all processes with nice values
ps lax

# sleep
sleep 3s

# List all files opened by process with PID 1
sudo lsof -p 1 > /home/bob/files.txt

# Identify PID of rpcbind and save its value
ps aux | pgrep rpcbind > pid.txt

# Identify CPU and memory usage by process 1
ps -u 1
```

### 48. Schedule Tasks to Run at a Set Date and Time

```Bash
#
```

### 52.  Lab: Manage Software, Repositories & Install Software from Source

```Bash
# Apt remove package with dependecies
sudo apt-get remove --auto-remove -y ziptool

# Run autogen.sh to generate the necessary build files
sudo ./autogen.sh

# Configure the build
sudo ./configure

# Compile the source code
sudo make

# Install the application
sudo make install

tmux
```

### 53. Verify Integrity and Availability of Resources and Processes

```Bash
# Disk usage
df -h

# Directory space usage
du -h /folder/

# RAM
free -h

# See load average
uptime

# lscpi, lscpu

# Integrity file sysytem
# Wa have to unount before
xfs_repair -v /dev/vdb1
sudo xfs_repair -n /dev/vdb > /home/bob/fscheck 2>&1

fsck.ext4 -v -f -p /dev/vdb2 # -p fix automatically

# Verify deamons
systemctl list-dependecies

systemctl status service

journalctl -u service
```

### 55. Change Kernel Runtime Parameters, Persistent and Non-Persistent

```Bash
# List all runtime parameters
sysctl -a

# Modify a value -w as write
# Non persistent changes
sysctl -w vm.percpu_pagelist_high_fraction=1

# Persistent changes
# Add a file /etc/sysctl.d/<filename>.conf
sysctl -p /etc/sysctl.d/<filename>.conf
/etc/sysctl.conf # could be modified by upgrade
```

### 56. List and Identify SELinux File and Process Contexts

```Bash
# SELinux context
# unconfine_u:object_r:user_home_t:s0
#     user      role       type    level
 id -Z # user context
 sudo semanage login -l

 # SELinux modes
 Getenforce
 Setenforce
```

### 57. Create and Enforce MAC Using SELinux

```Bash
# Check is SELinux run
sestatus
getenforce

# Audit SELinux
audit2why --all| less

# See wich process use particular context
ps -eZ | grep sshd_t

# Autorise all modules denied by SELinux
audit2allow --all -M mymodule
semodule -i mymodule.pp

# SELinux config
vim /etc/selinux/config

# Show labels
seinfo -u
seinfo -r

# Copy all chcon labels
chcon --reference=/var/log/dmasg /var/log/auth.log

# Restore labels
restorecon -F -R /var/www/ # -F force to relabel all types

# Set bbooleans
semanage boolean --list
```

### 58. Lab: Kernel Runtime Parameters and SELinux

```Bash

```

### 59. Create and Manage Containers

```Bash
docker images
docker ps -a
docker rm # remove containers
docker rmi # remove images
```

### 60. Manage and Configure Virtual Machines

```Shell
virsh # Manage virtual machines from cmd line
virsh list
virsh list --all
virsh start Machine
virsh shutdown Machine
```

## 4. Users and groups

### 65. Create, Delete, and Modify Local Groups and Group Memberships

```Shell
adduser john
groupadd developers
gpasswd --add john developers
gpasswd -a johne developers
gpasswd --delete john developers
gpasswd -d johne developers

# Change user's primary group
usermod -g developers john
usermod -gid developers john

# Rename a group
groupmod --new-name programmers developers
groupmod -n programmers developers

# Delet a group
groupdel programmers

# Password expiry 
chage - l username

# Create system account
adduser --system apachedev

# User password never expire
sudo usermod -e "" janec
hage -I -1 -m 0 -M 99999 -E -1 username


# User has to change password immediately
sudo chage --lastday 0 jane
passwd --expire jane
chage -M -1 baeldung
passwd -x -1 baeldung

# Add user to group
sudo usermod -a -G developers jane
```

### 67. Manage System-Wide Environment Profiles

```Shell
# Env variables
printenv
env
$HOME
$HISTSIZE

# ENv variables for all users
/etc/environment

# Execute sript when users logged in
/etc/profile.d/lastlogin.sh
```

### 68. Manage Template User Environment

```Shell
# /etc/skel - for new users
sudo /etc/skel/.bashrc
source .bashrc
source /etc/environment

# executed for all users
/etc/profile.d/todo.sh
# .bashrc
export PATH=$PATH:/path/to/folder
```

### 70. Configure User Resource Limits

```Shell
sudo vim /etc/security/limits.conf

# Limits of current user
ulimit -a
```

### 71. Manage User Privileges

```Shell
sudo

# Add to sudoers
sudo gpasswd -d trinity sudo 

# Delete from sudoers
sudo gpasswd -d trinity sudo 

# /etc/sudoers
visudo

%sudo ALL=(ALL:ALL) ALL
groupe host=(run as user a command, root by default:run as group a command, root by default) ALL
```

### 73. Manage Access to Root Account

```Shell
# To become root with sudo rights
sudo -i
sudo --login

# To become root with password
su -
su -l
su --login

# To lock
sudo passwd -l root
sudo passwd --lock root

# To unlock
sudo passwd -u root
sudo passwd --unlock root
```

## 5. Networking

### 76. Demo: Configure IPv4 and IPv6 Networking and Hostname Resolution

```Shell
# List interfaces
ip link

# IP
ip addr / ip a
ip -c addr # Details with colours

# Activate device
sudo ip link set dev enp0s8 up / down

# Add IP address
sudo ip addr add / delete 10.0.0.40/24 dev enp0s8

# Ubuntu Netplan /etc/netplan
sudo netplan get / try / apply

# Routes
sudo ip route

# DNS status /etc/systemd/resolved.conf
resolvectl status
systemctl restart systemd-resolved.service
```

### 79. Configure Bridge and Bonding Devices

```Shell
# Bridge <=> Bond devices
# Bridge => Connects two different network 
# Bond => redondance network cards
# Bonding modes 0 to 6
```

### 80. Demo: Configure Bridge and Bonding Devices

```Shell
sudo netplan try
sudo netplan apply
cat /proc/net/bonding/bond0
```

### 81. Configure Packet Filtering (Firewall)

```Shell
# UFW
# First rule match, first rule executed
ufw allow 22/tcp
ufw delete allow 22/tcp
ufw allow 22
ufw enable
ufw status
ufw allow from 10.0.0.192 to any port 22
ufw allow from 10.0.0.0/24 to any port 22
ufw status numbered
ufw delete 1

# Outgoing rule
ufw deny out on enp0s3 to 8.8.8.8
ufw allow in on enp0s3 from 10.0.0.192 to 10.0.0.0 proto tcp
```

### 85. Set and Synchronize System Time Using Time Servers

```Shell
# NTP servers
timedatectl list-timzone
timedatectl set-timezone America/Los_Angeles
vim /etc/systemd/timesyncd.conf.d/
```

### 86. Configure SSH Servers and Clients

```Shell
sudo vim /etc/ssh/sshd_config # daemon
sudo vim /etc/ssh/ssh_config # client

Port 22 # listen port
PermitRootLogin no
```

## 6. Storage

### 88. List, Create, Delete, and Modify Physical Storage Partitions

```Shell
lsblk
cfdisk
```

### 89. Configure and Manage Swap Space

```Shell
cfdisk
swapon --show # list
swapon /dev/sdb3
swapoff /dev/sdb3
mkswap /dev/sdb3 # create swap
dd if=/dev/zero of=/swap bs=1M count=128 status=progress
```

### 91. Create and Configure File Systems

```Shell
sudo mkfs.xfs /dev/sdb1
sudo mkfs.ext4 -L "BackupVolume" /dev/sdb1
man mkfs.ext4
sudo tune2fs -l /dev/sdb1
```

### 92. Configure Systems to Mount Filesystems at or During Boot

```Shell
mount
umount
system daemon-reload
lsblk
blkid
ls -l /dev/disk/by-uuid # list which UUID belong wich partition

# Change label on WFS filesystem
xfs_admin -L "SwapFS" /dev/vdb
```

### 94. Filesystem and Mount Options

```Shell
findmnt
findmnt -t btrfs,ext4,vfat #noexec, nosuid
man mount
man xfs
/etc/fstab
```

### 94. Use Remote Filesystems: NFS

```Shell
# NFS server / client
# Install nfs-kernel-server package
/etc/exports # Authorize wich machine can connect to our share
/home 192.0.0.0/24(ro,no_subtree_check) 127.0.0.10(rw,no_root_squash,no_subtree_check)

# Apply changes
exportfs -r # re-export
exportfs -v # verbose
```

### 94. Use Network Bloc Devices: NBD

```Shell
# https://medium.com/@aysadx/linux-nbd-introduction-to-linux-network-block-devices-143365f1901b
# with NBD, you can take a device like /dev/sda on one machine and make it available to another machine
# NBD server / client
# 3 ways on local machine: SWAP / File System / RAW
# Install nbd-server nbd-client
/etc/nbd-server/config
modeprobe nbd
vim /etc/modules-load.d/
nbd-client 127.0.0.1 -N partition2
```

### 99. Manage and Configure LVM Storage

```Shell
# Install lvm2
# PE : Physical volume
# VG : Volume group
# LV : Logical volume
# PE : 
pvs
vgcreate /dev/sds /dev/sdd
lvcreate
lvresize --extents 100%VG my_volume/partition1
lvresize --size 2G my_volume/partition1
lvdisplay
lvresize --resizefs --size 3G my_volume/partition1
```

### 100. Monitor Storage Performance

```Shell
# Install sysstat package
iostat / pidstat
```

### 102. Create, Manage, and Diagnose Advanced Filesystem Permissions

```Shell
# ACL
# + sign next to rights
setfacl --modify user:jeremy:rw file3
setfacl --modify mask:r file3
setfacl --remove-all file3
getfacl file3
setfacl --recursive -m user:jeremy:rwx dir1/
chattr +a newfile # we can append but not replace
chattr +i newfile # imutable
lasattr newfile

```
