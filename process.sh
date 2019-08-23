#!/bin/bash
#########################################################################
# File Name: process.sh
# Author: chaos
# mail: arch.liu@foxmail.com
# Created Time: 2019-08-21 09:51:46
#########################################################################


echo -n radio:
tput sc                                                                                                                  #保存当前光标位置
count=0
while true;
     do
         if [ $count -lt 10 ];then
             let count++;
             sleep 1;                                                                                                   #休眠1秒
             tput rc;                                                                                                   #取出当前光标位置
             tput ed
             #radia=`echo "scale=2;$count/10*100" | bc`
             #echo -n "$radia%";
             echo -n ". "
             tput sc
         else exit 0;
         fi
     done
echo
echo

i=0;
while [ $i -le $line_num ]
do
  let index=i%4
  let indexcolor=i%8
  let color=30+indexcolor
  printf "\e[0;$color;1m[%-${line_num}s][%d%%]%c\r" "$str" "$i" "${arr[$index]}"
  sleep 0.1
  let i++
  str+='='
done
printf "\n"
