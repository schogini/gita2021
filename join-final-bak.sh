#!/bin/sh



if [ $# -eq 0 ]; then
  echo No parameters entered Assuming S-P-T-S
  read a
  param="S-P-T-S"
else
  param=$1
fi

 # [ $param == "S-P-T-S" ] && echo YES

echo Press to proceed with param $param
read a 

# folder=CH-$(echo $0|sed 's/\.sh//'|sed 's/join-//'|tr a-z A-Z)
folder=CH-$param
if [ -d $folder ]; then 
  echo $folder already present.. press any key to DELETE and continue
  read a
  rm -fr $folder
fi

. ./settings.sh

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
 # ffmpeg  -i dummy.aiff  -f mp3 -acodec libmp3lame -ac 1 -ar 16k sloka.mp3
 ffmpeg  -i dummy.aiff $audio_settings sloka.mp3
 [ $? -ne 0 ] && echo ERROR-1 && exit
 #afplay ch-sloka.mp3

 # NEW
 rm current.mp3
 #cat chapter-name.mp3 sloka.mp3 | mp3cat - .
 # ffmpeg -i "concat:chapter-name.mp3|sloka.mp3" -acodec copy current.mp3
 [ $new -eq 0 ] && ffmpeg -i "concat:chapter-name.mp3|sloka.mp3" $audio_settings_copy current.mp3
 [ $new -eq 1 ] && ffmpeg -i chapter-name.mp3 -i sloka.mp3 -filter_complex "[0:a]atrim=end=10,asetpts=N/SR/TB[begin];[0:a]atrim=start=10,asetpts=N/SR/TB[end];[begin][1:a][end]concat=n=3:v=0:a=1[a]" -map "[a]"  current.mp3
 # [ $new -eq 1 ] && ffmpeg -i chapter-name.mp3 -i sloka.mp3 -filter_complex "[0:a]atrim=end=10,aformat=sample_rates=44100:channel_layouts=stereo,asetpts=N/SR/TB[begin];[1:a]aformat=sample_rates=44100:channel_layouts=stereo[middle];[0:a]atrim=start=10,aformat=sample_rates=44100:channel_layouts=stereo,asetpts=N/SR/TB[end];[begin][middle][end]concat=n=3:v=0:a=1[a]" -map "[a]" current.mp3
 # [ $new -eq 1 ] && ffmpeg -i chapter-name.mp3 -i sloka.mp3 -filter_complex "[0:a]atrim=end=10,asetpts=N/SR/TB[begin];[0:a]atrim=start=10,asetpts=N/SR/TB[end];[begin][1:a][end]concat=n=3:v=0:a=1[a]" -map "[a]" current.mp3
 # [ $new -eq 1 ] && ffmpeg -i chapter-name.mp3 -i sloka.mp3 $audio_settings_copy current.mp3
 [ $? -ne 0 ] && echo ERROR-2 && exit
 mv current.mp3 ch-sloka.mp3

 # DEBUGGING
 #cp chapter-name.mp3 ch-sloka.mp3
 #cp sloka.mp3 ch-sloka.mp3
}

d(){
cd /Volumes/SREE256GB/UNWANTED/GITA/
mkdir -p FINAL                                       
c=$1
s=$2
i=1
rm FINAL/$c/*

rm chapter-name.mp3  
ffmpeg -i ch-${c}.mp3 $audio_settings chapter-name.mp3
[ $? -ne 0 ] && echo ERROR-3 && exit
# ffmpeg -i ch-${c}.mp3 -acodec libmp3lame -ac 1 -ar 16k chapter-name.mp3

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
  # ffmpeg -i $pp -acodec libmp3lame -ac 1 -ar 16k -ab 128k audio-pp.mp3
  ffmpeg -i $pp $audio_settings audio-pp.mp3
  [ $? -ne 0 ] && echo ERROR-4 && exit
  rm audio-tt.mp3
  # ffmpeg -i $tt -acodec libmp3lame -ac 1 -ar 16k -ab 128k audio-tt.mp3
  ffmpeg -i $tt $audio_settings audio-tt.mp3
  [ $? -ne 0 ] && echo ERROR-5 && exit
  rm audio-ss.mp3
  # ffmpeg -i $ss -acodec libmp3lame -ac 1 -ar 16k -ab 128k audio-ss.mp3
  ffmpeg -i $ss $audio_settings audio-ss.mp3
  [ $? -ne 0 ] && echo ERROR-6 && exit
  rm audio-chsl.mp3
  # ffmpeg -i ch-sloka.mp3 -acodec libmp3lame -ac 1 -ar 16k -ab 128k audio-chsl.mp3
  ffmpeg -i ch-sloka.mp3 $audio_settings audio-chsl.mp3
  [ $? -ne 0 ] && echo ERROR-7 && exit
  # OUTPUT FOLDER/VARS
  mkdir -p FINAL/$c
  op=FINAL/$c/$ii.mp3

  # START ASSEMBLE
  rm current.mp3
  #cat ch-sloka.mp3 $ss audio-pp.mp3 audio-tt.mp3 $ss | mp3cat - .
 
  ffprobe audio-chsl.mp3
  # echo ffmpeg -i ch-sloka.mp3 $audio_settings audio-chsl.mp3
  ffprobe audio-ss.mp3
  # echo ffmpeg -i $ss $audio_settings audio-ss.mp3
  ffprobe audio-pp.mp3
  ffprobe audio-tt.mp3
  # echo ffmpeg -i $pp $audio_settings audio-pp.mp3
  # exit
  # ffmpeg -i audio-chsl.mp3 -i audio-ss.mp3 -i audio-pp.mp3 -i audio-tt.mp3
  # exit
  #ffmpeg -i "concat:ch-sloka.mp3|$ss|audio-pp.mp3|audio-tt.mp3|$ss" -acodec copy current.mp3
  # [ $param == "S-P-T-S" ] && ffmpeg -i "concat:audio-chsl.mp3|audio-ss.mp3|audio-pp.mp3|audio-tt.mp3|audio-ss.mp3" -ar 16k -ab 128k -acodec copy current.mp3
  
 

  if [  $mp3cat -eq 0 ]; then
  # [ $param == "S-P-T-S" ] && ffmpeg -i "concat:audio-chsl.mp3|audio-ss.mp3|audio-pp.mp3|audio-tt.mp3|audio-ss.mp3" $audio_settings_copy current.mp3
  
  if [ $new -eq 0 ]; then
    [ $param == "S-P-T-S" ] && ffmpeg -i "concat:audio-chsl.mp3|audio-ss.mp3|audio-pp.mp3|audio-tt.mp3|audio-ss.mp3" $audio_settings_copy current.mp3
  else  
    [ $param == "S-P-T-S" ] && ffmpeg -i audio-chsl.mp3 -i audio-ss.mp3 -i audio-pp.mp3 -i audio-tt.mp3 -i audio-ss.mp3 -filter_complex "[0:a]atrim=end=10,asetpts=N/SR/TB[begin];[0:a]atrim=start=10,asetpts=N/SR/TB[end];[begin][1:a][end]concat=n=3:v=0:a=1[a]" -map "[a]"  current.mp3
    # [ $param == "S-P-T-S" ] && ffmpeg -i audio-chsl.mp3 -i audio-ss.mp3 -i audio-pp.mp3 -i audio-tt.mp3 -i audio-ss.mp3 -filter_complex "[0:a]atrim=end=10,aformat=sample_rates=44100:channel_layouts=stereo,asetpts=N/SR/TB[begin];[1:a]aformat=sample_rates=44100:channel_layouts=stereo[middle];[0:a]atrim=start=10,aformat=sample_rates=44100:channel_layouts=stereo,asetpts=N/SR/TB[end];[begin][middle][end]concat=n=3:v=0:a=1[a]" -map "[a]" current.mp3
    # [ $param == "S-P-T-S" ] && ffmpeg -i audio-chsl.mp3 -i audio-ss.mp3 -i audio-pp.mp3 -i audio-tt.mp3 -i audio-ss.mp3 -filter_complex "[0:a]atrim=end=10,asetpts=N/SR/TB[begin];[0:a]atrim=start=10,asetpts=N/SR/TB[end];[begin][1:a][end]concat=n=3:v=0:a=1[a]" -map "[a]" current.mp3
    # [ $param == "S-P-T-S" ] && ffmpeg -i audio-chsl.mp3 -i audio-ss.mp3 -i audio-pp.mp3 -i audio-tt.mp3 -i audio-ss.mp3 $audio_settings_copy current.mp3
  fi
  # [ $param == "S-P-T-S-S" ] && ffmpeg -i "concat:audio-chsl.mp3|audio-ss.mp3|audio-pp.mp3|audio-tt.mp3|audio-ss.mp3|audio-ss.mp3" $audio_settings_copy current.mp3
  # [ $param == "S-P-T-S-S" ] && ffmpeg -i "concat:audio-chsl.mp3|audio-ss.mp3|audio-pp.mp3|audio-tt.mp3|audio-ss.mp3|audio-ss.mp3|audio-ss.mp3" $audio_settings_copy current.mp3
  else
   cat audio-chsl.mp3 audio-ss.mp3 audio-pp.mp3 audio-tt.mp3 | mp3cat - .
  fi
  # [ $? -ne 0 ] && echo ERROR-8 && exit
  #cat audio-pp.mp3 $ss | mp3cat - .
  # OUTPUT
  cp current.mp3 $op

  let i=${i}+1
#exit
done
cd ..
}


d 1 5
if [ 21 -eq 1 ]; then
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
fi

cd /Volumes/SREE256GB/UNWANTED/GITA/
echo Press to call CH.Sh
read a
sh ch.sh
mkdir -p $folder
cp -pr CHAPTER/* $folder/
echo cp -pr CHAPTER/* $folder

