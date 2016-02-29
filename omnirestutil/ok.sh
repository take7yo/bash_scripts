#! /bin/bash  
#chmod +x ./ok.sh
MPATH=`dirname $0`

LIBDIR_OTHER="$MPATH/auto/lib"  
SOURCEDIR="$MPATH/src"  
CLASSES="$MPATH/classes"
LIST="$MPATH/auto/list"
FILEPATH="$MPATH/omniRESTUtil"

if [ -d $FILEPATH ];then
rm -r $FILEPATH
mkdir $FILEPATH
fi

if [ ! -d $CLASSES ];then
mkdir $CLASSES
fi

rm -f $LIST/sources.list
find $SOURCEDIR -name *.java > $LIST/sources.list


TMP=`find $LIBDIR_OTHER -name "*.jar" | awk '{var=$0":"var;}END{print var;}'`
echo "$TMP"
javac -classpath $TMP -d $CLASSES @$LIST/sources.list


\cp -rf $MPATH/GenerateConf $CLASSES

java -classpath $TMP$CLASSES GeneratePro.Generator


