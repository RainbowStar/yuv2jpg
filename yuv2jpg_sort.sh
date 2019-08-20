#!/bin/bash
# discription: yuv转换jpg脚本
# 使用ffmpeg将.yuv图片转换成.jpg
# auther:star
# date:20190814

i=1
if [ ! -d "./jpg1"  ];then
    mkdir ./jpg1
fi
if [ ! -d "./jpg2"  ];then
    mkdir ./jpg2
fi

cat CALL.rect | while read line
do
    # echo $line
    # CALL-1.yuv timestamp:1565754707 stage1: stage2:F
    echo $((i++))
    if [[ $line =~ ^([^ ]+)\ ([^ ]+)\ (stage1[^ ]+)(\ (stage2[^ ]+))*.*$ ]]; then
        yuv_file=${BASH_REMATCH[1]}
        timestamp=${BASH_REMATCH[2]}
        stage1=${BASH_REMATCH[3]}
        stage2=${BASH_REMATCH[4]}
        if [ -f "$yuv_file" ] #file
        then
            echo "ok"
            if [[ $stage1 != '' && $stage2 == '' ]]; then
                ffmpeg -y -s 640x360 -i $yuv_file ./jpg1/${yuv_file%.*}.jpg < /dev/null
            elif [[ $stage1 != '' && $stage2 != '' ]]; then
                ffmpeg -y -s 640x360 -i $yuv_file ./jpg2/${yuv_file%.*}.jpg < /dev/null
            fi
            rm -f $yuv_file
        fi
    fi
done
