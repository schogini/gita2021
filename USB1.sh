
[ $(ls -l /Volumes/| grep -c SAREGAMA-S) -ne 1 ] && echo Insert USB && exit


find /Volumes/SAREGAMA-S -name "\.*" -exec rm -fr {} \; 2> /dev/null

cd /Volumes/SAREGAMA-S

list=""

show(){
 #echo $list
 #return
 cd /Volumes/SAREGAMA-S
 i=1
 #for f in $(ls -lt `find . -name "*.mp3" `|awk '{print $9}'|tac)
 for f in $list
 do
  ii=$(printf "%02d\n" $i) 
  echo $ii $f
  let i=$i+1
 done
}

if [ $# -ne 0 ]; then
 show
 exit
fi

t(){
 [ ! -d $1 ] && list="$list $1"
 qq=$(printf "%02d\n" $q) 
 #echo $1
 touch -m -t "${qq}01010101" $1
 let q=$q+1
 #sleep 1
}


cd /Volumes/SAREGAMA-S
q=1
t 1.mp3
show
exit


q=1
#t 1.mp3
t 991-Morning.mp3
t HanumanChalisa.mp3

#t CH-S-P
t MISC
#t CH-P-T-S

#cd /Volumes/SAREGAMA-S
#cd CH-S-P
#q=1
#t 1.mp3
#t 2.mp3

cd /Volumes/SAREGAMA-S



cd MISC
q=1
t Saraswati-Mantra-For-Concentration-In-Studies-OM-Shreem-Hreem-Saraswatyai-Namah.mp3
t study-music.mp3
t vipassana.mp3
t ANCIENT-SARASWATI-MANTRA-FOR-A-SHARP-MIND-AND-FOCUS.mp3
t om-namah-shivaya.mp3

#cd /Volumes/SAREGAMA-S
#cd CH-P-T-S
#q=1
#t 1.mp3
#t 2.mp3

show
