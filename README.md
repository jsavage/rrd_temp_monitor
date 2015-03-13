# rrd_temp_monitor
This is a simple set of scripts that use some round robin databases and graphs to 
help monitor temperatures in a property. 

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
- 3 x DS18B20 onewire Temperature sensors (Hot water flow temp, Central Heating flow temp and Ambient air temp)
