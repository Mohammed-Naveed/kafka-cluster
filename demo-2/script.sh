#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

# install java and kafka
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk
java -version

#wget ftp://apache.cs.utah.edu/apache.org/kafka/2.2.0/kafka_2.12-2.2.0.tgz
wget https://archive.apache.org/dist/kafka/2.2.0/kafka_2.12-2.2.0.tgz
sudo tar xvzf kafka_2.12-2.2.0.tgz
sudo chmod 777 kafka_2.12-2.2.0
export KAFKA_HEAP_OPTS="-Xmx256M -Xms128M"

cd kafka_2.12-0.10.2.0
cd kafka_2.12-2.2.0
sudo nohup bin/zookeeper-server-start.sh config/zookeeper.properties > ~/zookeeper-logs &