#!/bin/bash

# part 1
# go to home dir
cd ~

# create dirs D1/D2/D3
mkdir D1 && cd D1
mkdir D2 && cd D2
mkdir D3

# create empty txt in D2
touch file.txt

# add text in file.txt
echo "Hello guys :)))" > file.txt
cat file.txt

# create symbolic and hard link to file in D3
ln file.txt D3/hardl_file.txt
ln -s $(pwd)/file.txt $(pwd)/D3/syml_file.txt # or from D3

stat file.txt         # two links (hard)
stat syml_file.txt    # link is shown
cat D3/syml_file.txt D3/hardl_file.txt

# move file in D1 and chek links again
mv file.txt ../
stat file.txt         # two links (hard)
stat syml_file.txt    # link is shown, but wrong now
cat D3/syml_file.txt D3/hardl_file.txt
cd .. && rm -rf D2

# part 2
# print all files with size bigger then 50MB (with size info)
sudo find / -type f -size +50M -exec ls -hs {} \;

# print all common files changed in last 24 hours
find ~/ -type f -mtime -1

# check find command location and it's data
type -a find
cat /bin/find/    # trash (non-printible chars)
file /bin/find    # check info

# check type of /boot/initrd.img file
file /boot/initrd.img

# part 3
# page by page mode /var/log/auth.log and find sudo logs (/sudo, enter, n key)
less /var/log/auth.log
# page by page mode in reverse
tac /var/log/auth.log | less
# show name of current dir and filenames by one line and write it in cur_dir_files.txt
echo $(pwd) && ls > cur_dir_files.txt

# part 4
# in home dir print subdirs info only with subdirs name
ls -l ~/ | grep '^d' | tr -s ' ' | cut -d' ' -f 9
# the same in one line and ADD in cur_dir_files.txt
ls -l ~/ | grep '^d' | tr -s ' ' | cut -d' ' -f 9 | tr '\n' ' ' >> cur_dir_files.txt
# amount of differenet acces modes in /dev
ls -l /dev/ | tr -s ' ' | cut -d' ' -f 1 | sort | uniq -c | wc -l

# part 5
# print all command sterted with ls from man
man -k '^ls'
# print all yesterday logs from 1am to 5pm
export LC_ALL=is_US
sudo cat /var/log/syslog | grep -E "^$(date +%h) $(($(date +%d)-1)) (0[1-9]|1[0-6]):[0-5][0-9]:[0-5][0-9]"
# in ~/.bashrc change var LD_LIBRARY_PATH to /opt/rubackup/lib
sudo sed -i 's/^export LD_LIBRARY_PATH=.*/export LD_LIBRARY_PATH=\/opt\/rubackup\/lib/' .bashrc || \
sudo bash -c "echo \"export LD_LIBRARY_PATH=\"/opt/rubackup/lib\"\" >> .bashrc"
# in /home mkdir temp, and create files 1-20 .txt
mkdir ~/temp && cd ~/temp && mkdir file{1..20}.txt
# create bak subdir and copy files from temp to bak with .bak suffix
mkdir bak
ls | grep "file*" | awk '{print "cp -r " $1 " bak/"$1".bak"}' | bash
