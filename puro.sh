#!/bin/sh

d(){
c=$1
s=$2 
i=1
mkdir -p $c
cd $c
while [ $i -le $s ]
do
  ii=$(printf "%02d\n" $i)
  echo CH=$c SL=$ii of $s
  url="https://www.gitasupersite.iitk.ac.in/sites/default/files/audio/Purohit/${c}.${i}.mp3"
  curl -s -L -O "$url"
  let i=${i}+1
done
cd ..
}

cd /Volumes/SREE256GB/UNWANTED/GITA/

mkdir -p PUROHIT
cd PUROHIT

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
