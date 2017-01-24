#!/bin/sh

# This script is intended to be used on RaspberryPi platform, it performs
# the following actions:
#       - set mode out on PIN
#	- writes 1 and 0 on PIN
#
# Usage examples:
#       ./reset_lgw.rpi.sh stop
#       ./reset_lgw.rpi.sh start

# The reset pin of SX1301 is wired with RPi BCM25(wPi:6)
# If used on another platform, the GPIO number can be given as parameter.

GPIO='/usr/bin/gpio'
if [ -z "$2" ]; then 
    IOT_SK_SX1301_RESET_PIN=6
else
    IOT_SK_SX1301_RESET_PIN=$2
fi

echo "Accessing concentrator reset pin through GPIO$IOT_SK_SX1301_RESET_PIN..."

WAIT_GPIO() {
    sleep 0.1
}

iot_rpi_init() {
    # set GPIO  as output
    $GPIO mode 6 out; WAIT_GPIO

    # write output for SX1301 reset
    $GPIO write 1; WAIT_GPIO
    $GPIO write 0; WAIT_GPIO

    # set GPIO as input
    $GPIO mode 6 in; WAIT_GPIO
}

iot_rpi_term() {
    # cleanup GPIO
}

case "$1" in
    start)
    iot_rpi_term
    iot_rpi_init
    ;;
    stop)
    iot_rpi_term
    ;;
    *)
    echo "Usage: $0 {start|stop} [<gpio number>]"
    exit 1
    ;;
esac

exit 0
