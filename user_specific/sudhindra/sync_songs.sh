# usage --
# sync_songs.sh $source $destination

SOURCE=$1 #/Volumes/Home\ Directory/Music/hindi/
DESTINATION=$2 #~/mystuff/audio/hindi/

rsync -avh  $1 $2
