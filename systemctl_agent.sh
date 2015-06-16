#!/bin/sh

#
# Generic action script to control a service with Oracle Clusterware Agent Framework.
# The script uses systemctl to start, stop, clean or check the service.
#

# Define sleep and systemctl full paths
# Change this to match your system
SLEEP=/usr/bin/sleep
SYS_CTL=/usr/bin/systemctl

# Clusterware hands over the name of the service to start.
# We immediately fail if no service name given.
if [ -z "$_CRS_SVC_NAME" ]
  then
	  echo "CRS_ERROR: No service name given. Define attribute SVC_NAME on resource."
	  exit 1
fi

case $1 in
	'start')
		echo "CRS_PROGRESS: Calling $SYS_CTL start $_CRS_SVC_NAME"
		$SYS_CTL start $_CRS_SVC_NAME
		RET=$?
		$SLEEP 1
		;;
	'stop')
		echo "CRS_PROGRESS: Calling $SYS_CTL stop $_CRS_SVC_NAME"
		$SYS_CTL stop $_CRS_SVC_NAME
		RET=$?
		;;
	'clean')
		echo "CRS_PROGRESS: Calling $SYS_CTL stop $_CRS_SVC_NAME for cleaning"
		$SYS_CTL stop $_CRS_SVC_NAME
		RET=$?
		;;
	'check')
		$SYS_CTL is-active $_CRS_SVC_NAME
		RET=$?
		;;
	*)
		RET=0
		;;
esac
# 0: success; 1 : error
if [ $RET -eq 0 ]
  then exit 0
	else exit 1
fi
