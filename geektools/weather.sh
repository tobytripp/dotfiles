ZIPCODE=94538
# lynx -dump http://printer.wunderground.com/cgi-bin/findweather/getForecast?query=$ZIPCODE|awk '/Temp/{printf $2, ": "; for (i=3; i<=3; i++) printf $i " " }'
# 
# lynx -dump http://printer.wunderground.com/cgi-bin/findweather/getForecast?query=$ZIPCODE|awk '/Cond/ && !/Fore/ {for (i=2; i<=10; i++) printf $i " " }'
# 
curl --silent "http://xml.weather.yahoo.com/forecastrss?p=$ZIPCODE&u=c" | grep -E '(Low)' | sed -e 's/<br \/>//' -e 's///' -e 's///' -e 's///' -e 's///' -e 's///' -e 's///' -e 's///'

