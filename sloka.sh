#!/bin/sh

d(){
c=$1
s=$2 
i=1
mkdir -p $c
cd $c
while [ $i -le $s ]
#for i in {01..99}
do
 echo CH=$c SL=$i of $s
  url="https://www.gitasupersite.iitk.ac.in/sites/default/files/audio/CHAP${c}/${c}-${i}.MP3"
  curl -s -L -O "$url"
  let i=$i+1
  #[ $i -gt $s ] && break
done
cd ..
}

cd /Volumes/SREE256GB/UNWANTED/GITA/SLOKA

d 1 47
d 2 72
d 3 43
d 4 42
d 5 29
d 6 47
d 7 30
d 8 28
d 9 34
d 10 42
d 11 55
d 12 20
d 13 35
d 14 27
d 15 20
d 16 24
d 17 28
d 18 78
