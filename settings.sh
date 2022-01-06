#!/bin/sh

# audio_settings_copy="-ar 16k -ac 1 -f mp3 -b:a 16k -acodec copy"
# -ar 16k #sampling freq
# -ac 1 # mono
# -f mp3 
# -acodec libmp3lame
# https://ourcodeworld.com/articles/read/1435/how-to-convert-a-wav-file-to-mp3-using-ffmpeg
     audio_settings="-vn -ar 44100 -ac 1 -f mp3 -b:a 32k -acodec libmp3lame"
audio_settings_copy="-vn -ar 44100 -ac 1 -f mp3 -b:a 32k -acodec copy"

#ffmpeg -i input.mp3 -i second.mp3 -filter_complex "[0:a]atrim=end=10,asetpts=N/SR/TB[begin];[0:a]atrim=start=10,asetpts=N/SR/TB[end];[begin][1:a][end]concat=n=3:v=0:a=1[a]" -map "[a]" output

new=1
audio_settings_copy="-filter_complex \"[0:a]atrim=end=10,asetpts=N/SR/TB[begin];[0:a]atrim=start=10,asetpts=N/SR/TB[end];[begin][1:a][end]concat=n=3:v=0:a=1[a]\" -map \"[a]\""

#Note: All corresponding streams must have the same parameters in all segments; the filtering system will automatically select a common sample format, sample rate, and channel layout for audio streams. These common parameters will vary depending on the input parameters, so add the aformat filter (or equivalent) if you want consistent results:

#ffmpeg -i input.mp3 -i second.mp3 -filter_complex "[0:a]atrim=end=10,aformat=sample_rates=44100:channel_layouts=stereo,asetpts=N/SR/TB[begin];[1:a]aformat=sample_rates=44100:channel_layouts=stereo[middle];[0:a]atrim=start=10,aformat=sample_rates=44100:channel_layouts=stereo,asetpts=N/SR/TB[end];[begin][middle][end]concat=n=3:v=0:a=1[a]" -map "[a]" output

#audio_settings_copy="-filter_complex \"[0:a]atrim=end=10,aformat=sample_rates=44100:channel_layouts=stereo,asetpts=N/SR/TB[begin];[1:a]aformat=sample_rates=44100:channel_layouts=stereo[middle];[0:a]atrim=start=10,aformat=sample_rates=44100:channel_layouts=stereo,asetpts=N/SR/TB[end];[begin][middle][end]concat=n=3:v=0:a=1[a]\" -map \"[a]\""

#      audio_settings="-vn -ar 44100 -ac 1 -f mp3 -qscale:a 2 -acodec libmp3lame"
# audio_settings_copy="-vn -ar 44100 -ac 1 -f mp3 -qscale:a 2 -acodec copy"

mp3cat=0

# https://trac.ffmpeg.org/wiki/Encode/MP3
# libmp3lame -qscale:a 2
# ffmpeg -i input.wav -codec:a libmp3lame -qscale:a 2 output.mp3

# http://www.powyslug.org.uk/files/Converting_to_mp3_files_using_ffmpeg.pdf
# The simplest command, using default settings - 128kbits/s constant bit rate (CBR)
# ffmpeg -i source.wav output.mp3

# or explicitly specifying the audio codec
# ffmpeg -i source.wav -acodec libmp3lame output.mp3

# Specifying a constant bit rate – example using 64kbit/s
# ffmpeg -i source.wav -b:a 64k output.mp3

# CBR options are: 8k, 16k, 24k, 32k, 40k, 48k, 64k, 80k, 96k, 112k, 128k, 160k, 192k, 224k,
# 256k, or 320k. Higher numbers give better quality but larger files.

# Specifying a variable bit rate (VBR) using one of libmp3lame's quality options
# ffmpeg -i source.wav -q:a 4 output.mp3


# ffmpeg -i input1.wav -i input2.wav -i input3.wav -i input4.wav \
# -filter_complex '[0:0][1:0][2:0][3:0]concat=n=4:v=0:a=1[out]' -map '[out]' output.wav
# For example if you have five input files, use n=5 and add [4:0].

# ffmpeg -i kimberly.wav -acodec pcm_s16le -ar 16000 -ac 1 song.wav

mp3wav(){
	rm $2
	ffmpeg -i $1 -acodec pcm_s16le -ar 44100 -ac 1 $2
	# -acodec pcm_s16le -ar 44100 sample.wav
}
