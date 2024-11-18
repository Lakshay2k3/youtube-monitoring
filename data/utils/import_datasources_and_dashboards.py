import json
import os
import requests

host = "http://localhost:3000"
script_dir = os.path.dirname(os.path.abspath(__file__))

headers = {"Content-Type": "application/json"}
auth = ("admin","admin123456789")

for name in os.listdir(script_dir + '/datasources'):
    with open(os.path.join(script_dir + '/datasources', name)) as f:
        d = json.load(f)
        response = requests.post(host + '/api/datasources',
                                 headers=headers,
                                 auth=auth,
                                 data = json.dumps(d))
        
for name in os.listdir(script_dir + '/dashboards'):
    with open(os.path.join(script_dir + '/dashboards', name)) as f:
        d = json.load(f)
        response = requests.post(host + '/api/dashboards/db',
                                 headers=headers,
                                 auth=auth,
                                 data = json.dumps(d))

headers = {"Content-Type": "application/json"}
preferences = {"theme": "light", "homeDashboardUID": "m7BvUSxIk"}
response = requests.patch(host + '/api/user/preferences',
                         headers=headers,
                         auth=auth,
                         data = json.dumps(preferences))