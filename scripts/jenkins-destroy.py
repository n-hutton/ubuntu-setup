#!/usr/bin/env python3
import requests
import sys
import os


def to_json(r):
	if 200 <= r.status_code < 300:
		return r.json()

	print(r)
	print(r.status_code)
	print(r.text)
	sys.exit(1)

s = requests.session()
auth = ('ejfitzgerald', os.environ['JENKINS_TOKEN'])

data = to_json(s.get('https://jenkins.economicagents.com/queue/api/json', auth=auth))

queued_items = set()
for item in data['items']:
	queued_items.add(item['id'])

for item in queued_items:
	#print(f'Cancelling {item}...')
	params = {
		'id': item
	}
	r = s.post('https://jenkins.economicagents.com/queue/cancelItem', params=params, auth=auth)
	print(r)
