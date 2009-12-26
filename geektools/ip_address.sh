#! /bin/bash

myen0=`ifconfig en0 | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}'`

if [ "$myen0" != "" ]
then
    echo "Ethernet : $myen0"
else
    echo "Ethernet : INACTIVE"
fi

myen1=`ifconfig en1 | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}'`

if [ "myen1" != "" ]
then
    echo "AirPort  : $myen1"
else
    echo "Airport  : INACTIVE"
fi


myvar1=`system_profiler SPAirPortDataType | grep -e "Current Wireless Network:" | awk '{print $4}'`
myvar2=`system_profiler SPAirPortDataType | grep -e "Wireless Channel:" | awk '{print $3}'`

echo "Airport : $myvar1 - $myvar2"
