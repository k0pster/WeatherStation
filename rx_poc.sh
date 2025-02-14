#!/bin/bash 

#define city for which we want collect weather data
city=Szczecin

#download data for city from wttr.in webpage and store in 
#temp. file using curl command flag -s stand 
#for silent mode (no display on terminal) 
#and -T removing colors in output data
curl -s wttr.in/$city?T --output weather_report

#extract currect temperature
obs_temp=$(curl -s wttr.in/$city?T | grep -m 1 '°.' | grep -Eo -e '-?[[:digit:]]+' | head -1)
echo "The current temperature of $city: $obs_temp °C"

#extract forecast for next day data
fc_temp=$(curl -s wttr.in/$city?T | head -23 | tail -1 | grep '°.' | cut -d 'C' -f2 | grep -Eo -e '-?[[:digit:]]+' | head -1)
echo "The forecasted temperature for noon tommorow for $city: $fc_temp °C"

#assigne approprate Country and City to variable TZ
TZ='Europe/Warsaw'

#use commands to store rest durrent date data
day=$(TZ='Europe/Warsaw' date -u +%d)
month=$(TZ='Europe/Warsaw' date +%m)
year=$(TZ='Europe/Warsaw' date +%Y)

#merge fields into a tab-delimited record corresponding to single row
#and inserting it into rx_poc.log file
record=$(echo -e "$year\t$month\t$day\t$obs_temp°C\t$fc_temp°C")
echo $record >> rx_poc.log
