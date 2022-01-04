#!/bin/sh

folder=CH-$(echo $0|sed 's/\.sh//'|sed 's/join-//'|tr a-z A-Z)
[ -d $folder ] && echo $folder already present && exit

chsloka(){
 [ $1 -eq 1 ] && n="Arjuna's Vishada Yoga"
 [ $1 -eq 2 ] && n="Sankhya Yoga"
 [ $1 -eq 3 ] && n="Karma Yoga"
 [ $1 -eq 4 ] && n="Jnana-Karma-Sanyasa Yoga"
 [ $1 -eq 5 ] && n="Karma-Sanyasa Yoga"
 [ $1 -eq 6 ] && n="Atma-Samyama Yoga"
 [ $1 -eq 7 ] && n="Jnana-Vijnana Yoga"
 [ $1 -eq 8 ] && n="Aksara-ParaBrahma Yoga"
 [ $1 -eq 9 ] && n="Raja-Vidya-Raja-Guhya Yoga"
 [ $1 -eq 10 ] && n="Vibhuti Yoga"
 [ $1 -eq 11 ] && n="Viswarupa-Darsana Yoga"
 [ $1 -eq 12 ] && n="Bhakti Yoga"
 [ $1 -eq 13 ] && n="Ksetra-Ksetrajna-Vibhaga Yoga"
 [ $1 -eq 14 ] && n="Gunatraya-Vibhaga Yoga"
 [ $1 -eq 15 ] && n="Purushottama Yoga"
 [ $1 -eq 16 ] && n="Daivasura-Sampad-Vibhaga Yoga"
 [ $1 -eq 17 ] && n="Shraddhatraya-Vibhaga Yoga"
 [ $1 -eq 18 ] && n="Moksha-Sanyasa Yoga"

 #ffmpeg -i track1.aiff -f mp3 -acodec libmp3lame -ab 192000 -ar 44100 track1.mp3
 #say -o dummy.aiff "chapter $1, $n, slokam $2 of $s"
 say -o dummy.aiff "slokam $2 of $s"
 rm sloka.mp3
 ffmpeg  -i dummy.aiff  -f mp3 -acodec libmp3lame -ac 1      -ar 16k sloka.mp3
 #afplay ch-sloka.mp3

 # NEW

}

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

  #SLOKAM
  chsloka $c $i

  # VARS SETTING
  ss=SLOKA/${c}/${c}-${i}.mp3
  tt=TEJO/${c}/C${c}-H-${ii}.mp3
  pp=PUROHIT/${c}/${c}.${i}.mp3
  
  # FIX AUDIO FORMATS
  rm audio-pp.mp3
  ffmpeg -i $pp -acodec libmp3lame -ac 1 -ar 16k audio-pp.mp3
  rm audio-tt.mp3
  ffmpeg -i $tt -acodec libmp3lame -ac 1 -ar 16k audio-tt.mp3
  rm chapter-name.mp3  
  ffmpeg -i ch-${c}.mp3 -acodec libmp3lame -ac 1 -ar 16k chapter-name.mp3

  # OUTPUT FOLDER/VARS
  mkdir -p FINAL/$c
  op=FINAL/$c/$ii.mp3

  # START ASSEMBLE
  rm current.mp3
  cat chapter-name.mp3 sloka.mp3 audio-pp.mp3 audio-tt.mp3 $ss | mp3cat - .
  # OUTPUT
  cp current.mp3 $op

  let i=${i}+1
#exit
done
cd ..
}


#d 1 4
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

cd /Volumes/SREE256GB/UNWANTED/GITA/
sh ch.sh
cp -pr CHAPTER $folder

