#!/usr/bin/python3

from pprint import pprint
from kafka import KafkaConsumer

consumer = KafkaConsumer(bootstrap_servers='localhost:9092')
consumer.subscribe(['nwatson'])
pprint(vars(consumer))

for next_msg in consumer:
    print(next_msg)

