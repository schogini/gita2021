#!/bin/sh

d(){
cd /Volumes/SREE256GB/UNWANTED/GITA/
mkdir -p FINAL                                       
c=$1
s=$2
i=1
rm FINAL/$c/*
while [ $i -le $s ]
do
  ii=$(printf "%02d\n" $i)
  echo CH=$c SL=$ii of $s
  ss=SLOKA/${c}/${c}-${i}.mp3
  tt=TEJO/${c}/C${c}-H-${ii}.mp3
  pp=PUROHIT/${c}/${c}.${i}.mp3
  rm audio.mp3
  ffmpeg -i $pp -acodec libmp3lame -ac 1 -ar 16k audio.mp3

  mkdir -p FINAL/$c
  op=FINAL/$c/$ii.mp3
  rm current.mp3

  cat $ss audio.mp3 | mp3cat - .
  mv current.mp3 t1.mp3

  cat t1.mp3 $ss | mp3cat - .
  #mv current.mp3 t1.mp3
  #cat t1.mp3 $ss | mp3cat - .
  cp current.mp3 $op

  let i=${i}+1
done
cd ..
}


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


