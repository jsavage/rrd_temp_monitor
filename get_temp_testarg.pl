#!/usr/bin/perl
use LWP::UserAgent;

# To find a metar station nearest you, 
# use this list of stations http://weather.rap.ucar.edu/surface/stations.txt
# and replace the ICAO code KMSN with the ICAO code of the station 
# you would like to use at end of the $metar_url variable
 
my $dir = '.'; #'/path/to/your/temperature/scripts';
my $metar_url = 'http://weather.noaa.gov/pub/data/observations/metar/stations/KMSN.TXT';
my $is_celsius = 1; #set to 1 if using Celsius
 
my $ua = new LWP::UserAgent;
$ua->timeout(120);
my $request = new HTTP::Request('GET', $metar_url);
my $response = $ua->request($request);
my $metar= $response->content();
 
$metar =~ /([\s|M])(\d{2})\//g;
$outtemp = ($1 eq 'M') ? $2 * -1 : $2; #'M' in a METAR report signifies below 0 temps
$outtemp = ($is_celsius) ? $outtemp + 0 : ($outtemp * 9/5) + 32;
 
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
 
$output = "";
$attempts = 0;
while ($output !~ /YES/g && $attempts < 5)
{
        $output = `sudo cat /sys/bus/w1/devices/$ARGV[1]/w1_slave 2>&1`;
        if($output =~ /No such file or directory/)
        {
                print "Could not find DS18B20\n";
                last;
        }
        elsif($output !~ /NO/g)
        {
                print $output;
                $output =~ /t=(\d+)/i;
                $temp = ($is_celsius) ? ($1 / 1000) : ($1 / 1000) * 9/5 + 32;
                print "about to update rrd";
                $rrd = `/usr/bin/rrdtool update $dir/$ARGV[0].rrd $temp:$outtemp`;
                print $rrd;
        }
 
        $attempts++;
}
 
print "Inside temp: $temp\n";
print "Outside temp: $outtemp\n";
