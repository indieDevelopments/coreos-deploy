# coreos-deploy

This repo contains some scripts which help to deploy 3-node CoreOS cluster with SSL on DigitalOcean.

## Steptionary
```
# Generate cloud-config (new discovery record will be generated automatically).
$ cd ./gen_cloud_config && ./gen_config.sh

# Generate rules for iptables. This script transfer `rules-save` file to the host by public ip.
## We have to repeat execution 3 times for each node.
$ cd ../gen_iptables_config && ./gen_rules.sh \ 
	--core01=NODE_01_PRIVATE_IP \ 
	--core02=NODE_02_PRIVATE_IP \ 
	--core03=NODE_03_PRIVATE_IP \ 
	--ip=NODE_*_PUBLIC_IP

# Generate cfssl certs for each node
## That script generates certs according to the template and uploads certs to the node.
## Repeat 3 times for each node in cluster.
$ cd ../gen_cfssl \ 
	&& ./gen_core_instance.sh \ 
		--name=NODE_*_NAME \ 
		--privateip=NODE_*_PRIVATE_IP \ 
	&& ./gen_cfssl.sh --name=NODE_*_NAME --ip=NODE_*_PUBLIC_IP

# Move `rules-save` to `/var/lib/iptables/` and reload specific service.
## Repeat 3 times for each node.
$ ssh -A core@NODE_*_PUBLIC_IP 'sudo mv rules-save /var/lib/iptables/ \ 
	&& sudo systemctl restart iptables-restore'
```

Now we can connect to the first node in cluster via SSH. There won\'t be any services which works incorrect if everything is ok.