# Build-only intermediate image
FROM debian:trixie-slim AS stage0

# Install Debian-provided python packages instead of using pip, will
#  reduce build time considerably
# Otherwise: pip install requests pybluez pycryptodomex bluepy paho-mqtt
RUN apt-get update \
	&& apt-get -y --no-install-recommends install \
		build-essential \
		libbluetooth-dev \
		libglib2.0-dev \
		python3-pip

RUN python3 -m pip config set global.break-system-packages true \
# Wheel is required for bluepy to build properly. *MUST* run as separate calls to pip install
&& python3 -m pip install --upgrade setuptools wheel \
&& pip3 install bluepy

FROM debian:trixie-slim

# Install Debian-provided python packages instead of using pip, will
#  reduce build time considerably
# Otherwise: pip install requests pybluez pycryptodomex bluepy paho-mqtt
RUN apt-get update \
	&& apt-get -y --no-install-recommends install \
		libcap2-bin \
		python3-bluez \
		python3-pip \
		python3-pycryptodome \
                curl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# /usr/local/lib will only contain the packages installed by pip
COPY --from=stage0 /usr/local/lib/ /usr/local/lib/

COPY ./*.py /app/
COPY ./entrypoint.sh /app/
COPY ./sensors.ini /app/
COPY ./sendToInflux.sh /app/

ENTRYPOINT ["/app/entrypoint.sh"]
