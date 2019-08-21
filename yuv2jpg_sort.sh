#!/bin/bash
# discription: yuv转换jpg脚本, 根据rect里面的stage进行判断
# 使用ffmpeg将.yuv图片转换成.jpg
# auther:star
# date:20190820

stage1_jpg=jpg1
stage2_jpg=jpg2
list_file=CALL.rect

if [ ! -e "./$stage1_jpg"  ];then
    \mkdir ./$stage1_jpg
fi
if [ ! -e "./$stage2_jpg"  ];then
    \mkdir ./$stage2_jpg
fi

line_num=$(\wc -l < $list_file)

i=1
cat $list_file | while read line
do
    # echo $line
    printf "line %d / %d : \t" $((i++)) $line_num
    #      CALL-n.yuv timestamp:nnn... stage1:T... stage2:F...
    if [[ $line =~ ([^ ]+)\ ([^ ]+)\ (stage1[^ ]+)(\ (stage2[^ ]+))* ]]; then
        yuv_file=${BASH_REMATCH[1]}
        timestamp=${BASH_REMATCH[2]}
        stage1=${BASH_REMATCH[3]}
        stage2=${BASH_REMATCH[4]}
        if [ -f "$yuv_file" ] #file
        then
            if [[ $stage1 =~ 'stage1:T' && $stage2 =~ 'stage2:F' ]]; then
                echo "stage1"
                \ffmpeg -loglevel quiet -y -s 640x360 -i $yuv_file ./jpg1/${yuv_file%.*}.jpg < /dev/null
            elif [[ $stage1 =~ 'stage1:T' && $stage2 =~ 'stage2:T' ]]; then
                echo "stage1 & stage2"
                \ffmpeg -loglevel quiet -y -s 640x360 -i $yuv_file ./jpg2/${yuv_file%.*}.jpg < /dev/null
            else
                echo ""
            fi
            \rm -f $yuv_file
        fi
    else
        echo "$yuv_file not exist"
    fi
done

echo "finished!"

