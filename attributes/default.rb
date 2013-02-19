default['ipf']['ip_ranges']=`curl -s https://www.cloudflare.com/ips-v4`
default['ipf']['private_ranges']=["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]