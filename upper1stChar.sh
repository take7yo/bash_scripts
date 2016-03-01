#!/bin/bash
## 检查当前系统信息
if [[ `uname` != "Linux" ]]; then
    echo "当前脚本只支持在Linux环境中执行。当前系统为：`uname`"
    exit -1
fi
originalFile=$1
targetFile=$2
## 判断原始文件是否存在，不过不存在，返回提示信息并退出处理。
if [ -e "${originalFile}" ] && [ -f "${originalFile}" ]; then
    ## 获取文件内容
    #cat ${originalFile}
    echo "完成文件内容获取"
else
    echo "请输入原始文件"
    exit 0
fi
## 处理文件信息
originalFilePath=`dirname ${originalFile}`
echo "原始文件目录：${originalFilePath}"
originalFilename=`basename ${originalFile}`
echo "原始文件名称：${originalFilename}"
targetFilename=target_${originalFilename}
echo "目标文件名称：${targetFilename}"
## 函数定义
function output() {
    originalWord=$1
    targetWord=$2
    resStr="${targetWord}  string \`form:\"${originalWord}\"\`"
    # echo ${resStr}
    echo ${resStr} >> ${originalFilePath}/${targetFilename}
}
function upper1stCase() {
    originalWord=${1}
    targetWord=""
    # echo "输入参数：${originalWord}"
    if [ -z "${originalWord}" ]; then
        break
    fi
    if [[ ${originalWord} =~ "_" ]]; then
        i=1
        while (( 1==1 ))
        do
            split=`echo ${originalWord} | cut -d "_" -f${i}`
            if [ "${split}" != "" ]; then
                ((i++))
                split=`echo ${split} | sed 's/^./\U&/'`
                targetWord=${targetWord}${split}
                # echo "target word: ${targetWord}"
            else
                # echo "....break...."
                break
            fi
        done
    else
        targetWord=`echo ${originalWord} | sed 's/^./\U&/'`
    fi
    echo "转换前字符串：${originalWord}; 转换后字符串：${targetWord}."
    output ${originalWord} ${targetWord}
}
#datas=`cat ${originalFile}`
## 设置for循环行读取分隔符
#IFS="
#"
#for i in ${datas}
#do
#    echo "原始字符串：${i}"
#done
cat ${originalFile} | while read line
do
    # echo "原始字符串：${line}"
    upper1stCase ${line}
done
