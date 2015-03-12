#Call this script from crontab.  Edit crontab with crontab -e
echo $(date)  # log the date and time
cd /home/pi/rrdtool/
# ToDo: amend script so that this log file does not grow forever  
./update_allkitchentemps.sh >>cronlog.log
./2create_all_rrd_graphs.sh >>cronlog.log
cd allkitchen # this is where all the graphs are put
#Combine the graphs
convert -append temp*.png all.png
#Now copy to the folder on the webserver overwriting the previous ones
cp *.png /var/www/temps
