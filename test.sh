#!/bin/bash
#########################################################################
# File Name: test.sh
# Author: chaos
# mail: arch.liu@foxmail.com
# Created Time: 2019-08-20 18:54:54
#########################################################################

if [ ! -d "./test"  ];then
    mkdir ./test
fi

cp yuv_file/* test
cd test
# bash ../yuv2jpg_sort.sh
bash ../yuv2jpg.sh
ls -l *
echo
ls -l */*

find . -name "call*.rect" -exec echo {} \; -exec cat -n {} \; -exec echo \;

cd ..
diff -r test result_1

echo "finished"
