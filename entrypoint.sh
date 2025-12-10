#!/bin/sh
python3 /app/LYWSD03MMC.py -a --devicelistfile /app/sensors.ini --influxdb 1 -r -b --callback sendToInflux.sh
