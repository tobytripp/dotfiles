#!/bin/bash

asbreg=`ioreg -rc "AppleSmartBattery"`

maxcap=`echo "${asbreg}" | awk '/MaxCapacity/{print $3}'`;
curcap=`echo "${asbreg}" | awk '/CurrentCapacity/{print $3}'`;

prcnt=`echo "scale=2; 100*$curcap/$maxcap" | bc`;

printf "%1.0f%%" ${prcnt};

#EOF