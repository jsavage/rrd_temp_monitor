#!/usr/bin/perl
use LWP::UserAgent;

# To find a metar station nearest you, 
# use this list of stations http://weather.rap.ucar.edu/surface/stations.txt
# and replace the ICAO code KMSN with the ICAO code of the station 
# you would like to use at end of the $metar_url variable
 
my $dir = 'allkitchen'; #'/path/to/your/temperature/scripts';
#my $metar_url = 'http://weather.noaa.gov/pub/data/observations/metar/stations/KMSN.TXT';
my $is_celsius = 1; #set to 1 if using Celsius
 
#my $ua = new LWP::UserAgent;
#$ua->timeout(120);
#my $request = new HTTP::Request('GET', $metar_url);
#my $response = $ua->request($request);
#my $metar= $response->content();
 
#$metar =~ /([\s|M])(\d{2})\//g;
#$outtemp = ($1 eq 'M') ? $2 * -1 : $2; #'M' in a METAR report signifies below 0 temps
#$outtemp = ($is_celsius) ? $outtemp + 0 : ($outtemp * 9/5) + 32;
 
$modules = `cat /proc/modules`;
if ($modules =~ /w1_therm/ && $modules =~ /w1_gpio/)
{
        #modules installed
}
else
{
        $gpio = `sudo modprobe w1-gpio`;
        $therm = `sudo modprobe w1-therm`;
}

#./get_temp_testarg.pl kitchen 28-0000061548cf
#./get_temp_testarg.pl hotwater 28-041451089bff
#./get_temp_testarg.pl heating 28-041451726dff

 
$output = "";
$attempts = 0;
while ($output !~ /YES/g && $attempts < 5)
{
        $output = `sudo cat /sys/bus/w1/devices/28-0000061548cf/w1_slave 2>&1`;
        $output2 = `sudo cat /sys/bus/w1/devices/28-041451089bff/w1_slave 2>&1`;
        $output3 = `sudo cat /sys/bus/w1/devices/28-041451726dff/w1_slave 2>&1`;

        if($output =~ /No such file or directory/)
        {
                print "Could not find DS18B20\n";
                last;
        }
        elsif($output !~ /NO/g)
        {
#                print $output;
                $output =~ /t=(\d+)/i;
                $temp = ($is_celsius) ? ($1 / 1000) : ($1 / 1000) * 9/5 + 32;
 #               print "output:\n";
  #              print $output;
   #             print "temp:\n";
    #            print $temp;
     #           print "\n";
                $output2 =~ /t=(\d+)/i;
                $temp2 = ($is_celsius) ? ($1 / 1000) : ($1 / 1000) * 9/5 + 32;
      #          print "output2:\n";
       #         print $output2;
        #        print "temp2:\n";
         #       print $temp2;
          #      print "\n";
                $output3 =~ /t=(\d+)/i;
                $temp3 = ($is_celsius) ? ($1 / 1000) : ($1 / 1000) * 9/5 + 32;
#                print "output3:\n";
 #               print $output3;
  #              print "temp3:\n";
   #             print $temp3;
    #            print "\n";
     #           print "about to update rrd:\n";

#               The following line is where the data gets put into the rrd
                $rrd = `/usr/bin/rrdtool update $dir.rrd N:$temp:$temp2:$temp3`;
#
#                Now publish this data to mqtt
#
                mosquitto_pub -t "rrd/#" -m 'update $dir.rrd N:$temp:$temp2:$temp3`;
        }
 
        $attempts++;
}
 
print "Temp Inside Kitchen: $temp\n";
print "Hotwater flow temp: $temp2\n";
print "Heating flow temp: $temp3\n";

