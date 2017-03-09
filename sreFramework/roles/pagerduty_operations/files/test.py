from ansible.module_utils.basic import *
import time
import datetime
import os.path
import subprocess
import os
import requests
import json
from array import *

def get_pd_incidents(service_ids, trigger_time):
	time_zone = 'UTC'
	statuses = ['triggered']
	headers = {'Accept': 'application/vnd.pagerduty+json;version=2', 'Authorization': 'Token token=Hpx84vx2o23L7xkxCbyU'}
	payload = {'time_zone': time_zone, 'statuses': statuses, 'service_ids': service_ids ,  'since': trigger_time, 'include': "first_trigger_log_entries"}
	url = 'https://api.pagerduty.com/incidents'
	resp = requests.get(url, params=json.dumps(payload), headers=headers)
	#incident_ids = []
	incidents = resp.json().get('incidents')
	
	final_resp = {}
	for incident in incidents:
		filtered_incident = []
		#incident_ids.append(incident["id"])
		filtered_incident.append({"status":incident["status"],"description":incident["description"]})
		final_resp[incident["id"]] = filtered_incident

	print json.dumps(final_resp, indent=2)


def main():
	pd_operation = "get_pd_incidents";
	pd_service_id = "PDLU44T"
	if(pd_operation == "get_pd_incidents"):
		# Creating an array of service IDs as PD API expects that
		service_ids = [pd_service_id]
		trigger_time = datetime.datetime.utcnow().isoformat()
		result = get_pd_incidents(service_ids,trigger_time)
	#module.exit_json(result=result)


if __name__ == '__main__':
	main()