#!/bin/bash
dir=$1
if [ -z $1 ]
        then echo "Укажите директорию для выполнения скрипта"
else
cd $1
USERS=($(ls -lA | cut -d " " -f3 | grep -v '^$'  | sort | uniq))
for ((a=0; a < ${#USERS[@]}; a++))
        do
        u=${USERS[$a]}
        mkdir  $u
        chown $u $u
        find -maxdepth 1 -not -name "." -not -name ".." -not -name $u -user $u -exec cp -a {} $u \;
done
fi