#!/bin/bash
vcodec="mp2v" 
acodec="mp2a" 
bitrate="4096" 
arate="192" 
ext="mpg" 
mux="ps" 
vlc="/usr/bin/vlc" 
fmt="avi" 

for a in *$fmt; do 
    $vlc -I dummy -vvv "$a" --sout "#transcode{vcodec=$vcodec,vb=$bitrate,acodec=$acodec,ab=$arate,channels=6,deinterlace,audio-sync}:standard{access=file,mux=$mux,dst=\"$a.$ext\"}" vlc://quit 
done
