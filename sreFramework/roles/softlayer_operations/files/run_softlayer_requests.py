#!/usr/bin/python
import sys
import requests
import SoftLayer
from SoftLayer import VSManager

def run_softLayer_requests(sl_hostname,sl_service_endpoint,sl_username,sl_api_key):
	headers= {'Content-Type': 'application/json'}
	client = SoftLayer.create_client_from_env(username=sl_username, api_key=sl_api_key)
	mgr = SoftLayer.VSManager(client)
	sl_initialization_parameter = get_id_from_hostname(mgr,sl_hostname)
	sl_url = "https://"+sl_username+":"+sl_api_key+"@api.softlayer.com/rest/v3/SoftLayer_Virtual_Guest/"+str(sl_initialization_parameter)+"/"+sl_service_endpoint
	output = requests.get(sl_url, headers=headers, timeout=1200)
	print output.json()


def get_id_from_hostname(mgr,sl_hostname):
	slVms = mgr.list_instances(hostname=sl_hostname)
	for vm in slVms:
		if vm:
			return vm['id']
		else:
			return "hostname not found"  


def main(argv):
	sl_operation = argv[1]
	sl_hostname = argv[2]
	sl_username = argv[3]
	sl_api_key = argv[4]
	run_softLayer_requests(sl_hostname, sl_operation, sl_username, sl_api_key)
	return 0


if __name__ == '__main__':
    main(sys.argv)
