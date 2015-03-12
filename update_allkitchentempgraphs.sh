echo $(date)
cd /home/pi/rrdtool/
./update_allkitchentemps.sh >>cronlog.log
./2create_all_rrd_graphs.sh >>cronlog.log
cd allkitchen
convert -append temp*.png all.png
cp *.png /var/www/temps
