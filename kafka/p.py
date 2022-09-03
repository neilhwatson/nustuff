#!/usr/bin/python3

from kafka import KafkaProducer
import re
import requests

producer = KafkaProducer(bootstrap_servers='localhost:9092')

config = {
    'github': {
        'url': 'https://www.githubstatus.com/',
        'body': 'All Systems Operational',
        'timeout': 5 # TODO make a default timeout
    }
}

def test(url
for next_topic in config.keys():
    # Note that measuring total response time we may be measruing DNS too
    r = requests.get(config[next_topic]['url'], timeout=config[next_topic]['timeout'])

    # MVP+1 no blocking checks
    print(r.status_code)
    print(r.elapsed)
    if re.search(config[next_topic]['body'], r.text):
        print('body OK')

# future = producer.send('nwatson', b'hello world')
# result = future.get(timeout=4)
