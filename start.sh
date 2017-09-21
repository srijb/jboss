#!/bin/sh
JB=/opt/app/jboss-eap-6.4/bin
/bin/rm -rf _file1.txt
/bin/rm -rf new1.txt
ps aux|grep "java"|egrep -v 'grep|defunct' >_file1.txt
new1=$(ls -ltr _file1.txt|awk '{printf $5}')
if [ "$new1" == "0" ]
then
sudo $JB/./domain.sh --domain-config=domain.xml --host-config=host.xml
else
#PID=$(cat _file1.txt|awk '{printf $2}')
#echo "Jboss is Up and Running WITH PID=$PID"
cat _file1.txt|while read -r var
do
PID=$(echo "$var"|awk '{printf $2" "}')
PR=$(echo "$var"|cut -d "[" -f2|cut -d "]" -f1)
#PID=$('$var' |awk '{printf $2}')
echo "Jboss is Up and Running ($PR) with  PID=$PID"
done 
fi
