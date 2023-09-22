#!/bin/bash

# part 1
# show terminal name and type
tty
echo ${TERM}

# new terminal created
tty
ls /dev/pts

# part 2
# create another terminal and check rows/columns in terminal
tput cols && tput lines

# part 3
# check autocomplete with tab after ls and $HIST
ls
# to check command buffer size
echo ${HISTFILESIZE}

# part 4
# 4.1 print all files in /home directory with name started with .c
find ~/ -type f -name ".c*"
# 4.2 setting time in command history output
export HISTTIMEFORMAT="%F %T "
# OR echo "\nHISTTIMEFORMAT="%F %T"\n" >> ~/.bashrc && source ~/.bashrc
history
# OR history -t "%F %T"
# 4.3 autosave commands in history
# 4.3a any command
date
# 4.3b check command in history
history | tail -2
# 4.3c define PROMPT_COMMAND so cache is saved in hist file
# -a permanently add command in hist
# -c clear history
# -r add reloaded history in shell
export PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND}"
# OR echo -e "\nexport PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND}"\n" \ 
# >> ~/.bashrc && source ~/.bashrc
# 4.3d any command and check it in hist
date
history
# 4.4 add DATE var with date, TIME var with time and DATE_TIME as their sum
DATE=`date +%F`
TIME=`date +%T`
DATE_TIME="${DATE} ${TIME}"

echo ${DATE_TIME}

# part 5
# print all files conatining one or more numbers from /bin and /bins
ls /bin | grep '[0-9]'
ls /sbin | grep '[0-9]'

# set mcedit as default for vipw
export EDITOR=/usr/bin/mcedit
sudo vipw
# EDITOR=/usr/bin/mcedit sudo vipw

# print HH:MM in hostname
# try export
export HOSTNAME="ru01wks163-$(date +%H):$(date +%M).miet.stu"
# new term -- nothing happens
sudo bash -c "echo \"export HOSTNAME=\"ru01wks163-$(date +%H):$(date +%M).miet.stu\"\" >> .bashrc"
# new term -- woo a lya

# make dirs with all months of current year
mkdir $(date +%Y)-{01..12}


