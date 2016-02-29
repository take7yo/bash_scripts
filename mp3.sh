#!/bin/bash
url=$1
dirname=$2
echo "url is ${url}; dirname is ${dirname}."
# 目录操作
rm -rf ${dirname}
mkdir ${dirname}
cd ${dirname}
# 文件操作
filename=${dirname}.txt
links=link_${filename}
names=name_${filename}
linkfile=lf_${filename}
# 抓取网页
echo "curl ${url} > ${filename}"
curl ${url} > ${filename}
# 抓取链接节点
echo "cat ${filename} | grep '.*thumb=\"\(.*.mp3\)\">' > ${links}"
cat ${filename} | grep '.*thumb=\"\(.*.mp3\)\">' > ${links}
# 抓取文件名节点
echo "cat ${filename} | grep '<a target=\"_blank\" href=\".*\" alt=\"\(.*\)\">.*</a>' > ${names}"
cat ${filename} | grep '<a target=\"_blank\" href=\".*\" alt=\"\(.*\)\">.*</a>' > ${names}
# 抓取链接列表
echo 'sed "s/.*thumb=\"\(.*.mp3\)\">/\1/g"' ${links}
sed "s/.*thumb=\"\(.*.mp3\)\">/\1/g" ${links} > ${filename}
cat ${filename} > ${links}
# echo "cat ${links}"
# cat ${links}
# 统计音频个数
filenum=`grep -c "" ${links}`
# 抓取文件名列表
echo 'sed "s/.*<a target=\"_blank\" href=\".*\" alt=\"\(.*\)\">.*</a>.*/\1/g"' ${names}
sed "s/.*<a target=\"_blank\" href=\".*\" alt=\"\(.*\)\">.*<\/a>.*/\1/g" ${names} > ${filename}
cat ${filename} > ${names}
#echo "cat ${names}"
#cat ${names}
for (( i=1; i<=${filenum}; i++ ))
	do		
	echo `sed -n ${i}p ${links}`
	sed -n ${i}p ${links} > ${linkfile}
	wget `cat ${linkfile} | tr -d '\r'`
	oldfn=`sed "s/.*\/\(.*\).mp3/\1/g" ${linkfile} | tr -d '\r'`
	newfn=`sed -n ${i}p ${names} | tr -d '\r'`
	echo "old file name is ${oldfn}"
	echo "new file name is ${newfn}"
	mv "${oldfn}.mp3" "${newfn}.mp3"
done
# 删除临时文件
rm -f *.txt