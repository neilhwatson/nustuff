#!/usr/bin/python3

from kafka import KafkaProducer

producer = KafkaProducer(bootstrap_servers='localhost:9092')

future = producer.send('nwatson', b'hello world')
result = future.get(timeout=4)
