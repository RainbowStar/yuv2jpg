#!/bin/bash
# discription: yuv转换jpg脚本
# 使用ffmpeg将.yuv图片转换成.jpg
# auther:star
# date:20190814

for yuv_file in *.yuv #查找当前目录下所有文件/目录
do
    if [ -f "$yuv_file" ] #file
    then
    ffmpeg -y -s 640x360 -i $yuv_file ${yuv_file%.*}.jpg
    rm -f $yuv_file
    fi
done
