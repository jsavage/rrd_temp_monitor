# rrd_temp_monitor
This is a simple set of scripts that use some round robin databases and graphs to help monitor temperatures in a property.  I am measuring Hot water flow temp, Central Heating flow temp and Ambient air temp in the Kitchen with one RaspberryPi which also has mosquitto and a webserver running and I am measuring Ambient air temperarture in the Sitting Room using another RaspberryPi.  For the record this solution to my needs was inspired and informed by  http://blog.turningdigital.com/2012/09/raspberry-pi-ds18b20-temperature-sensor-rrdtool/

Key differences: 
-More parameters being graphed
-No need for ftp of sftp to transfer files
-Not currently using metar
-The resulting graphs are assembled into a single image
-Introduction of mqtt pub/sub to send data to a remote rrd  (not completed yet)
-Graphing of more than one mqtt feed (not completed) 
-Graphing PIR activity (not completed)
-Graphing audio levels (not completed)
-Graphing Lighting levels (not completed)
-Graphing power consumption (not completed)

All mistakes are mine

Dependencies
perl - sudo apt-get install libwww-perl
rrdtool - sudo apt-get install rrdtool
mosquitto - sudo apt-get install mosquitto
mosquitto commandline clients -  sudo apt-get install mosquitto-clients

1. cron calls update_allkitchentempgraphs.sh 
which then calls
2. update_allkitchentemps.sh 
and then
3. 2create_all_rrd_graphs.sh 
before
4. amalgamating all graphs into a single image in /allkitchen

alternatively (not in use at present)

1. cron calls update_allkitchentempgraphs2.sh 
which then calls
2. update_allkitchentemps2.sh 
and then
3. 2create_all_rrd_graphs2.sh 
before
4. amalgamating all graphs into a single image in /4wltctemps

Hardware:
-Raspberry Pi B V1.0
- 3 x DS18B20 onewire Temperature sensors 
