#!/bin/sh

# This script is intended to be used on RaspberryPi platform, it performs
# the following actions:
#       - set mode out on PIN
#		- writes 1 and 0 on PIN
#
# Usage examples:
#       ./reset_gps.rpi.sh

# The reset pin of nGPS_Reset is wired with RPi BCM24(wPi:5)
# If used on another platform, the GPIO number can be given as parameter.

GPIO='/usr/bin/gpio'
if [ -z "$2" ]; then 
    RPI_SX1301_RESET_PIN=5
else
    RPI_SX1301_RESET_PIN=$2
fi

echo "Accessing concentrator reset pin through GPIO$RPI_SX1301_RESET_PIN..."

WAIT_GPIO() {
    sleep 0.1
}

gps_rpi_reset() {
    # set GPIO  as output
    $GPIO mode $RPI_SX1301_RESET_PIN out; WAIT_GPIO

    # write output for SX1301 reset
    $GPIO write $RPI_SX1301_RESET_PIN 1; WAIT_GPIO
    $GPIO write $RPI_SX1301_RESET_PIN 0; WAIT_GPIO

    # set GPIO as input
    $GPIO mode $RPI_SX1301_RESET_PIN in; WAIT_GPIO
}

gps_rpi_reset

exit 0
