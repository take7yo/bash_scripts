#!/bin/bash
    # shell 脚本中的字符串操作
    # ${#string}	$string的长度
    # ${string:position}	在$string中, 从位置$position开始提取子串
    # ${string:position:length}	在$string中, 从位置$position开始提取长度为$length的子串
    # ${string#substring}	从变量$string的开头, 删除最短匹配$substring的子串
    # ${string##substring}	从变量$string的开头, 删除最长匹配$substring的子串
    # ${string%substring}	从变量$string的结尾, 删除最短匹配$substring的子串
    # ${string%%substring}	从变量$string的结尾, 删除最长匹配$substring的子串
    # ${string/substring/replacement}	使用$replacement, 来代替第一个匹配的$substring
    # ${string//substring/replacement}	使用$replacement, 代替所有匹配的$substring
    # ${string/#substring/replacement}	如果$string的前缀匹配$substring, 那么就用$replacement来代替匹配到的$substring
    # ${string/%substring/replacement}	如果$string的后缀匹配$substring, 那么就用$replacement来代替匹配到的$substring

# 将当前目录下的HTML文件备份一份为TPL文件
path=$1
if [ ! -n "$path" ]; then
    path="./"
fi
# 判断传入目录是否存在
if [ ! -d "$path" ]; then
    # 输出当前操作目录信息
    echo current directory: $(pwd)
    path="./"
else
    echo current directory: $(cd $path; pwd)
fi
files=`find $path -name '*.html' -type 'f'`
for F in $files ;
    do
    F=${F//\/\//\/};
    #echo $F;
    cp -vf $F ${F%.html}.tpl;
    #rm -vf ${F%.html}.tpl;
done