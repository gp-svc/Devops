#!/bin/bash

#myname='linux'
#echo $myname

httpd_service_sts=`systemctl status httpd` httpd_sts=$?
#echo $httpd_sts

dt=`date "+%d%b%YY-%H:%M"`
if [ $httpd_sts -eq 0 ] ; then
        echo "logging at ${dt} no action required " >> /root/httpd_restart.log
else
        echo "logging at ${dt} service in down state - I will trigger the service now at" >> /root/httpd_restart.log
        systemctl restart httpd
fi
