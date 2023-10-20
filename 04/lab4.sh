#!/bin/bash

# part 1
top
# 1.1
# to delete VIRT, RES and SHR
# 'f' key, 'd'/'space' key on these parameters
# 2.2
# to add RUSER and place after USER
# 'f', 'd'/'space' on this parameter
# 'right arrow', arrows key to move, enter to finish
# print all process with several threads
ps -eLf | awk '{
  if ($6 > '1')
    print $10;
}'

# part 2
# new terminal
passwd
# check top output
# 'U' key, type username filter, 'enter'
# 'O' key, type COMMAND=passwd, 'arrow left' to show filter
# '=' to reset filters
# check PID (36371), and sent signals
kill -15 36371
# kill SIGTERM 36371
# nothing
kill -2 36371
# kill SIGINT 36371
# nothing
kill -3 36371
# kill SIGQUIT 36371
# nothing
kill -9 36371
# kill SIGKILL 36371
# kiled

# part 3
# in terminal, where passwd killed
sleep 600
# type ctrl-Z to suspend (jobs command)
jobs
# sleep 600 is suspended, task number is 1
bg %1
# continued sleep

# part 4
# change NICE for 'sleep 600' with 10 (PID=36980)
renice -n 10 36980
# check NICE (NI) in top

# part 5
# in terminal, where passwd killed
sleep 600
# 'o', type COMMAND=passwd, check PID (36980)
kill -15 36980
# sleep terminated
jobs
# empty output
# echo "Signal is blocked" when getting signals in current terminal
trap 'echo "Signal is blocked"' SIGINT SIGQUIT
# reset trap
trap - SIGINT SIGQUIT