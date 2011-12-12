# usage ---
# rip.sh /path/to/filename.vob

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

folder=$1/*

for filename in $folder; do
  echo $filename
  HandBrakeCLI -i $filename -o $filename.mp4
done

IFS=SAVEIFS
