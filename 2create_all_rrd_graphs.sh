#!/bin/bash
DIR="allkitchen"
echo $DIR 
#set to C if using Celsius
TEMP_SCALE="C"
 
#define the desired colors for the graphs
COLOR1="#00ff00" #Green
COLOR2="#ff0000" #Purple
COLOR3="#880000" #Brown
#hourly
rrdtool graph $DIR/temp_hourly.png --start -6h \
DEF:kitchentemp=$DIR'.rrd':kitchentemp:AVERAGE \
AREA:kitchentemp$COLOR1:"Inside Temperature [deg $TEMP_SCALE]" \
DEF:hotwatertemp=$DIR'.rrd':hotwatertemp:AVERAGE \
LINE1:hotwatertemp$COLOR2:"Hot water flow Temperature [deg $TEMP_SCALE]" \
DEF:heatingtemp=$DIR'.rrd':heatingtemp:AVERAGE \
LINE2:heatingtemp$COLOR3:"Heating flow Temperature [deg $TEMP_SCALE]"

#daily
rrdtool graph $DIR/temp_daily.png --start -1d \
DEF:kitchentemp=$DIR'.rrd':kitchentemp:AVERAGE \
AREA:kitchentemp$COLOR1:"Inside Temperature [deg $TEMP_SCALE]" \
DEF:hotwatertemp=$DIR'.rrd':hotwatertemp:AVERAGE \
LINE1:hotwatertemp$COLOR2:"Outside Temperature [deg $TEMP_SCALE]" \
DEF:heatingtemp=$DIR'.rrd':heatingtemp:AVERAGE \
LINE2:heatingtemp$COLOR3:"Heating flow Temperature [deg $TEMP_SCALE]" 

#weekly
rrdtool graph $DIR/$1/temp_weekly.png --start -1w \
DEF:kitchentemp=$DIR'.rrd':kitchentemp:AVERAGE \
AREA:kitchentemp$COLOR1:"Inside Temperature [deg $TEMP_SCALE]" \
DEF:hotwatertemp=$DIR'.rrd':hotwatertemp:AVERAGE \
LINE1:hotwatertemp$COLOR2:"Outside Temperature [deg $TEMP_SCALE]" \
DEF:heatingtemp=$DIR'.rrd':heatingtemp:AVERAGE \
LINE2:heatingtemp$COLOR3:"Heating flow Temperature [deg $TEMP_SCALE]"

#monthly
rrdtool graph $DIR/$1/temp_monthly.png --start -1m \
DEF:kitchentemp=$DIR'.rrd':kitchentemp:AVERAGE \
AREA:kitchentemp$COLOR1:"Inside Temperature [deg $TEMP_SCALE]" \
DEF:hotwatertemp=$DIR'.rrd':hotwatertemp:AVERAGE \
LINE1:hotwatertemp$COLOR2:"Outside Temperature [deg $TEMP_SCALE]" \
DEF:heatingtemp=$DIR'.rrd':heatingtemp:AVERAGE \
LINE2:heatingtemp$COLOR3:"Heating flow Temperature [deg $TEMP_SCALE]"

