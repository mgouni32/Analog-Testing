FROM resin/raspberrypi3-node
#RUN echo "ipv6" >> /etc/modules

#switch on systemd init system in container
ENV INITSYSTEM on

RUN apt-get update && apt-get install -y \
	git-core \
	gcc \
	python-pip 

#RUN pip install pyserial
RUN git clone git://git.drogon.net/wiringPi
RUN cd wiringPi && ./build

COPY . /wiringPi
WORKDIR /wiringPi

#Compile watchdog script
RUN gcc -o pub.o pub.c -lwiringPi
CMD ./pistart.sh