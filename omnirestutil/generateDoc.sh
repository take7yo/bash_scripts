#!/bin/bash
filename="GenerateConf"
oldDbName=`grep "\"dbName\":\"\(.*\)\"" ./${filename} | cut -d "\"" -f 4`
newDbName=$1
bkfolder=$2
bkfile=$3
if [ -z "${newDbName}" ]; then
    echo "please input the new db name as the first parameter."
    exit 0
fi
echo oldDbName: ${oldDbName}, newDbName: ${newDbName}
# rename dbname
sed -i "s/${oldDbName}/${newDbName}/g" ./${filename}
# delete doc if exists
docFolder="./doc/${newDbName}"
if [ -d ${docFolder} ]; then
    # if need to backup old folder, backup. if not, remove the old folder.
    if [ "${bkfolder}" == "n"  ]; then
        echo "remove ${docFolder}"
        rm -rf ${docFolder}
    else
        oldFolderModifyTime=`stat doc | grep "最近更改\|Modify" | cut -d "：" -f2 | awk '{print $1$2}' | sed 's/-//g' | sed 's/://g'`
        echo "rename ${docFolder} to ${docFolder}_${oldFolderModifyTime}"
        mv ${docFolder} ${docFolder}_${oldFolderModifyTime}
    fi
fi
# generate new doc file
./ok.sh
if [ ! $? == 0 ]; then
    echo "generate apidoc failed. please check the new db name."
    exit 0
fi
apiFolder="/home/java/src/omnirest/src/hjy/test/v1_3/${newDbName}/"
apiName="apidoc"
apidoc=${apiFolder}${apiName}
echo "apidoc path: ${apidoc}"
if [ -f ${apidoc} ]; then
    # if need to backup the old apidoc, just do it
    if [ "${bkfile}" != "n" ]; then
        oldFileModifyTime=`stat ${apidoc} | grep "最近更改\|Modify" | cut -d "：" -f2 | awk '{print $1$2}' | sed 's/-//g' | sed 's/://g'`
        echo "rename ${apidoc} to ${apidoc}_${oldFileModifyTime}"
        mv ${apidoc} ${apidoc}_${oldFileModifyTime}
    fi
fi
# copy new apidoc to omnirest project
echo "cp ${docFolder}/apidoc to  ${apidoc}"
cp ${docFolder}/apidoc ${apidoc}

echo "omnirest config file path: ${apiFolder}"

echo "finish"

docker restart omnirest
echo "docker restart omnirest"
