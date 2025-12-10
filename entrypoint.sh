#!/bin/sh
python3 /app/MiTemperature2.py --devicelistfile /app/sensors.ini --influxdb 1 -r -b --callback sendToInflux.sh
