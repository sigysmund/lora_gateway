#!/bin/sh

# This script is intended to be used on RaspberryPi platform, it performs
# the following actions:
#       - set mode out on PIN
#		- writes 1 and 0 on PIN
#
# Usage examples:
#       ./enable_lgw.rpi.sh

# The enable pin of GPS Module LDO is wired with RPi BCM23(wPi:4)
# If used on another platform, the GPIO number can be given as parameter.

GPIO='/usr/bin/gpio'
if [ -z "$2" ]; then 
    RPI_GPS_ENABLE_PIN=4
else
    RPI_GPS_ENABLE_PIN=$2
fi

echo "Accessing concentrator ENABLE pin through GPIO$RPI_GPS_ENABLE_PIN..."

WAIT_GPIO() {
    sleep 0.1
}

gps_rpi_enable() {
    # set GPIO  as output
    $GPIO mode $RPI_GPS_ENABLE_PIN out; WAIT_GPIO

    # write output for SX1301 ENABLE
    $GPIO write $RPI_GPS_ENABLE_PIN 1; WAIT_GPIO
}

gps_rpi_enable

exit 0
