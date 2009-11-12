
GeekTool:

Vnstat(Graphical network data): vnstat -u -q -i en0 --hours

Weather: curl --silent "http://xml.weather.yahoo.com/forecastrss?p=CAXX0400&u=c" | grep -e "Forecast:" -A 2 | tail -n 2 | sed -e 's/<br \/>//' -e 's/<BR \/>//' | sed "s/\(.*\)\.\ \(.*\)/\1\?\2/" | tr "?" "\n" | sed "s/High\:\ \(.*\)\ Low\:\ \(.*\)/\?H\: \1\ L\:\ \2/" | sed "s/\?\(.*\)/\\1/" 

Time: date "+%l:%M"

Date: date +%d

Mont: date +%B

Day: date +%A

DiskUsage: df -h | grep disk0s2 | awk '{print "Macintosh HD:", $2, "total,", $3, "used,", $4, "remaining"}'

Netstat: netstat -ab -f inet | grep -i established

Top: top -FR -l2 | grep '^....[1234567890] ' | grep -v ' 0.0% ..:' | cut -c 1-24,33-42,64-77

Webcam: http://images.drivebc.ca/bchighwaycam/pub/cameras/30.jpg

Text: echo "Current Conditions"

Uptime: uptime | awk '{print "UPTIME : " $3 " " $4 " " $5 }' | sed -e 's/.$//g'; top -l 1 | awk '/PhysMem/ {print "RAM : " $8 " "}' ; top -l 2 | awk '/CPU usage/ && NR > 5 {print $6, $7=":", $8, $9="user ", $10, $11="sys ", $12, $13}'
FileSystem: df -H -l

P.M.: date "+% %p "

Forecast: curl -s http://www.wunderground.com/cgi-bin/findweather/getForecast?query=49.05%2C-123.11 | awk '/Today is/ || /Tomorrow is/' | textutil -convert txt -stdin -stdout -format html

Conditions: curl --silent "http://xml.weather.yahoo.com/forecastrss?p=CAXX0400&u=c" | grep -E '(Current Conditions:|C<BR)' | sed -e 's/Current Conditions://' -e 's/<br \/>//' -e 's/<b>//' -e 's/<\/b>//' -e 's/<BR \/>//' -e 's/<description>//' -e 's/<\/description>//'

ToDo: cat /Users/Peter/Documents/tasks.taskpaper

FuzzyClock: sh /Users/Peter/fuzzy.bash

Code below>

#!/bin/bash
# converts exact time to fuzzy format
export exact_time=$(date '+%I:%M')
 
export exact_hour=$(echo $exact_time | cut -c 1,2)
export exact_minute=$(echo $exact_time | cut -c 4,5)
 
case $exact_hour in
    01) export fuzzy_hour='one';;
    02) export fuzzy_hour='two';;
    03) export fuzzy_hour='three';;
    04) export fuzzy_hour='four';;
    05) export fuzzy_hour='five';;
    06) export fuzzy_hour='six';;
    07) export fuzzy_hour='seven';;
    08) export fuzzy_hour='eight';;
    09) export fuzzy_hour='nine';;
    10) export fuzzy_hour='ten';;
    11) export fuzzy_hour='eleven';;
    12) export fuzzy_hour='twelve';;
esac
 
case $exact_minute in
    00) export fuzzy_minute='o-clock';;
    01) export fuzzy_minute='o-one';;
    02) export fuzzy_minute='o-two';;
    03) export fuzzy_minute='o-three';;
    04) export fuzzy_minute='o-four';;
    05) export fuzzy_minute='o-five';;
    06) export fuzzy_minute='o-six';;
    07) export fuzzy_minute='o-seven';;
    08) export fuzzy_minute='o-eight';;
    09) export fuzzy_minute='o-nine';;
    10) export fuzzy_minute='ten';;
    11) export fuzzy_minute='eleven';;
    12) export fuzzy_minute='twelve';;
    13) export fuzzy_minute='thirteen';;
    14) export fuzzy_minute='fourteen';;
    15) export fuzzy_minute='fifteen';;
    16) export fuzzy_minute='sixteen';;
    17) export fuzzy_minute='seventeen';;
    18) export fuzzy_minute='eighteen';;
    19) export fuzzy_minute='nineteen';;
    20) export fuzzy_minute='twenty';;
    21) export fuzzy_minute='twenty-one';;
    22) export fuzzy_minute='twenty-two';;
    23) export fuzzy_minute='twenty-three';;
    24) export fuzzy_minute='twenty-four';;
    25) export fuzzy_minute='twenty-five';;
    26) export fuzzy_minute='twenty-six';;
    27) export fuzzy_minute='twenty-seven';;
    28) export fuzzy_minute='twenty-eight';;
    29) export fuzzy_minute='twenty-nine';;
    30) export fuzzy_minute='thirty';;
    31) export fuzzy_minute='thirty-one';;
    32) export fuzzy_minute='thirty-two';;
    33) export fuzzy_minute='thirty-three';;
    34) export fuzzy_minute='thirty-four';;
    35) export fuzzy_minute='thirty-five';;
    36) export fuzzy_minute='thirty-six';;
    37) export fuzzy_minute='thirty-seven';;
    38) export fuzzy_minute='thirty-seven';;
    39) export fuzzy_minute='thirty-one';;
    40) export fuzzy_minute='forty';;
    41) export fuzzy_minute='forty-one';;
    42) export fuzzy_minute='forty-two';;
    43) export fuzzy_minute='forty-three';;
    44) export fuzzy_minute='forty-four';;
    45) export fuzzy_minute='forty-five';;
    46) export fuzzy_minute='forty-six';;
    47) export fuzzy_minute='forty-seven';;
    48) export fuzzy_minute='forty-eight';;
    49) export fuzzy_minute='forty-nine';;
    50) export fuzzy_minute='fifty';;
    51) export fuzzy_minute='fifty-one';;
    52) export fuzzy_minute='fifty-two';;
    53) export fuzzy_minute='fifty-three';;
    54) export fuzzy_minute='fifty-four';;
    55) export fuzzy_minute='fifty-five';;
    56) export fuzzy_minute='fifty-six';;
    57) export fuzzy_minute='fifty-seven';;
    58) export fuzzy_minute='fifty-eight';;
    59) export fuzzy_minute='fifty-nine';;
esac
 
export fuzzy_time="$fuzzy_hour $fuzzy_minute"
echo $fuzzy_time
exit 0
 
# Local variables:
# Coding: utf-8 
# End:










