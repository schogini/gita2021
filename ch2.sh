#!/bin/sh

d(){
cd /Volumes/SREE256GB/UNWANTED/GITA/
mkdir -p FINAL                                       
c=$1
s=$2
i=1
mkdir -p CHAPTER
op=CHAPTER/$c.mp3
while [ $i -le $s ]
do
  ii=$(printf "%02d\n" $i)
  echo CH=$c SL=$ii of $s
  #ffmpeg -i "concat:SLOKA/1/1-1.mp3|TEJO/1/C1-H-01.mp3|PUROHIT/1/1.1.mp3" -acodec copy output.mp3
  op=FINAL/$c/$ii.mp3
  #ffmpeg -f concat -safe 0 -i mylist.txt -c copy $op
  rm tmp.mp3
  if [ $i -eq 1 ]; then
    rm CHAPTER/$c.mp3
    rm tmp.mp3 tmp2.mp3 current.mp3
    #cp $op tmp.mp3
    #cp $op tmp2.mp3
    cat $op | mp3cat - .
    cp current.mp3 tmp.mp3
    cp current.mp3 tmp2.mp3
  else    
    cp tmp2.mp3 tmp.mp3
    rm tmp2.mp3
    # ffmpeg -i "concat:tmp.mp3|$op" -acodec copy tmp2.mp3
    rm current.mp3
    cat tmp.mp3 $op | mp3cat - .
    ls -lh current.mp3
    cp current.mp3 tmp2.mp3
    #ls -l tmp.mp3 tmp2.mp3 $op 
  fi
  let i=${i}+1
#exit
done
ls -lh current.mp3
cp current.mp3 CHAPTER/$c.mp3
cd ..
}


d 1 5
exit
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


