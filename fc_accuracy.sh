#!/bin/bash

#define yesterday, today temperature and calculate diffrence
#to check diffrences and degree accuracy of forecast
yesterday_fc=$(tail -2 rx_poc.log | head -1 | cut -d " " -f5 | grep -Eo -e '-?[[:digit:]]+')
today_temp=$(tail -1 rx_poc.log | cut -d " " -f4 | grep -Eo -e '-?[[:digit:]]+')
accuracy=$(($yesterday_fc-$today_temp))
echo "accuracy is $accuracy"

#change accuracy value to string according to table:
#accuracy range | accuracy label
#+/- 1 st.        excellent
#+/- 2 st.        good
#+/- 3 st.        fair
#+/- 4 st.        bad

if [ -1 -le $accuracy ] && [ $accuracy -le 1 ]
then
	accuracy_range=excellent
elif [ -2 -le $accuracy ] && [ $accuracy -le 2 ]
	then
		accuracy_range=good
	elif [ -3 -le $accuracy ] && [ $accuracy -le 3 ]
	then
		accuracy_range=fair
	else
		accuracy_range=poor
fi

echo "Forecast accuracy is $accuracy_range"

#next update file historical_fc_accuracy.tsv
row=$(tail -1 rx_poc.log)
year=$( echo $row | cut -d " " -f1)
month=$( echo $row | cut -d " " -f2)
day=$( echo $row | cut -d " " -f3)
echo -e "$year\t$month\t$day\t$today_temp\t$yesterday_fc\t$accuracy\t$accuracy_range" >> historical_fc_accuracy.tsv

