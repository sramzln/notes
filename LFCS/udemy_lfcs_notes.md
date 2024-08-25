# LFCS UDEMY COURSE

## Essential Commands

### 14 - Create, delete, copy and move files

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

### 15,16 - create and manage Hard ans Soft Links

```Bash
# Hard link
# We can delete a file for a user, it will be accessible fo another
# hard link only on same file-system, file to file NOT FOLDER
ln path_to_target_file path_to_link_file

## symbolic link, on files and folders too and accessible on different file-system.
## readlink if link name is too long
ln -s target link
```

### 19 - SUID, SGID ans Sticky Bit

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

### 20,21 - Search for files, compare and manipulate file contents

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

### 25 - Ananlyze text using basic regular expressions

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

### 28,29 - Archive, Back UP, unpack, compress / Uncompress Files

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

### 30 - Backup to a remote system

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

### 31 - Input, output redirection, pipelineing

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

### 33-36 SSL Certificates, GIT

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

### 38 - Boot, Reboot, Shutdown

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

### 41 - Scripting ti automate system maintenance tasks

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

### 42 - Manage Startup Process ans Services

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

### 43 - Create systemd services

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

### 44 - LAB

```Bash
#!/bin/bash
systemctl is-enabled sshd.service
```

### 45 - Diagnose and manage processes

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

### 46 - Locate and analyse system file logs

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

### 47 - LAB manage process and analyze logs

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

### 48 - Schedule Tasks to Run at a Set Date and Time

```Bash
#
```

### 52 -  Lab: Manage Software, Repositories & Install Software from Source

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

### 53 - Verify Integrity and Availability of Resources and Processes

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

### 55 - Change Kernel Runtime Parameters, Persistent and Non-Persistent

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

### 56 - List and Identify SELinux File and Process Contexts

```Bash
# SELinux context

```

### 57 - Create and Enforce MAC Using SELinux

```Bash

```

### 58 - Lab: Kernel Runtime Parameters and SELinux

```Bash

```

### 5

```Bash

```

