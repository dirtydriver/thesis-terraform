import json

with open("terraformout.json") as file:
    data=file.read()

json_data=json.loads(data)

resources=json_data['values']['root_module']['resources']

droplets=filter(lambda x: x['type'] == "digitalocean_droplet",resources)

print(json.dumps(droplets))