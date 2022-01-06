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
qqq=""
qqqq=""
ar=""
iii=0
while [ $i -le $s ]
do
  ii=$(printf "%02d\n" $i)
  echo CH=$c SL=$ii of $s
  op=FINAL/$c/$ii.wav
  q="$q $op "
  qqq="$qqq|$op"
  ar="$ar[$iii:0]"
  qqqq="$qqqq -i $op "
  let i=${i}+1
  let iii=${iii}+1
#exit
done
rm current.wav
# echo $q
#exit
#du -sh $q
#   cat $q|mp3cat - - > CHAPTER/$c.mp3
# cat $q|mp3cat - .

#ffmpeg -i "concat:file1.mp3|file2.mp3" -acodec copy output.mp3
qqq=$(echo $qqq|sed 's/^\|//')
echo $qqqq

. ./settings.sh


# exit

let n=$s

echo "========================="
echo i=$i iii=$iii s=$s n=$n
echo $ar
echo $qqqq
echo "========================="

if [  $mp3cat -eq 0 ]; then
  [ $new -eq 0 ] && ffmpeg -i "concat:$qqq" $audio_settings_copy current.mp3
  [ $new -eq 1 ] && ffmpeg $qqqq -filter_complex "${ar}concat=n=$n:v=0:a=1[out]" -map "[out]" current.wav
  # [ $new -eq 1 ] && ffmpeg $qqqq -filter_complex "[0:0][1:0][2:0][3:0][4:0]concat=n=$n:v=0:a=1[out]" -map "[out]" current.wav
  # [ $new -eq 1 ] && ffmpeg $qqqq -filter_complex "[0:a]atrim=end=10,aformat=sample_rates=44100:channel_layouts=stereo,asetpts=N/SR/TB[begin];[1:a]aformat=sample_rates=44100:channel_layouts=stereo[middle];[0:a]atrim=start=10,aformat=sample_rates=44100:channel_layouts=stereo,asetpts=N/SR/TB[end];[begin][middle][end]concat=n=3:v=0:a=1[a]" -map "[a]" current.mp3
  # [ $new -eq 1 ] && ffmpeg $qqqq -filter_complex -filter_complex "[0:a]atrim=end=10,aformat=sample_rates=44100:channel_layouts=stereo,asetpts=N/SR/TB[begin];[1:a]aformat=sample_rates=44100:channel_layouts=mono;[0:a]atrim=start=10,aformat=sample_rates=44100:channel_layouts=mono,asetpts=N/SR/TB[end];[begin][middle][end]concat=n=3:v=0:a=1[a]" -map "[a]" current.mp3
  # [ $new -eq 1 ] && ffmpeg $qqqq $audio_settings_copy current.mp3
else
  cat $q |mp3cat - .
fi
# [ $? -ne 0 ] && echo ERROR-CH-1 && exit
#mv current.mp3 CHAPTER/$c.mp3
# exit 
ls -l current.wav CHAPTER/$c.wav
mv current.wav CHAPTER/$c.wav
rm CHAPTER/$c.mp3
# ffmpeg -i CHAPTER/$c.wav $audio_settings CHAPTER/$c.mp3
# ffmpeg -i CHAPTER/$c.wav "-vn -ar 44100 -ac 1 -f mp3 -b:a 32k -acodec libmp3lame" CHAPTER/$c.mp3
ffmpeg -i CHAPTER/$c.wav -vn -ar 48000 -ac 1 -f mp3 -b:a 128k -acodec libmp3lame CHAPTER/$c.mp3
# rm CHAPTER/$c.wav
#ls -lh $q current.mp3
#cp current.mp3 CHAPTER/$c.mp3
cd ..
}


# d 1 5
# exit
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


