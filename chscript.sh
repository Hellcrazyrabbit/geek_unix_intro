#!/bin/bash
a=$1
if [ -z $a ]
    then echo "Enter file name to change: ./chscript file"
else
    b="out${a}"
    sed '/^$/d' $a > $b
    tr [:lower:] [:upper:] < $a > $b
    echo  'Corrected file ' $b 'created'
fi