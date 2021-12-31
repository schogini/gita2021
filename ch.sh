#!/bin/sh

d(){
cd /Volumes/SREE256GB/UNWANTED/GITA/
mkdir -p FINAL                                       
c=$1
s=$2
i=1
mkdir -p CHAPTER
op=CHAPTER/$c.mp3
q=""
while [ $i -le $s ]
do
  ii=$(printf "%02d\n" $i)
  echo CH=$c SL=$ii of $s
  op=FINAL/$c/$ii.mp3
  q="$q $op "
  let i=${i}+1
#exit
done
#rm current.mp3
echo $q
#exit
#du -sh $q
cat $q|mp3cat - - > CHAPTER/$c.mp3
#ls -lh $q current.mp3
#cp current.mp3 CHAPTER/$c.mp3
cd ..
}


#d 1 47
#exit
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


