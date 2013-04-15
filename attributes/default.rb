# Ranges:
# populate the inbound_public_ranges attribute with a
# newline-delimited array of ips

default['ipf']['rule_type']="string" # string or array
default['ipf']['use_metadata']=false # add pass_in rule from joyent matadataAPI.
default['ipf']['key_metadata']="ipfilter_pass_in" # only works in array mode. 
## example of matadata,conma separated strings ) "192.168.1.0/24,192.168.1.0/24"

case node['ipf']['rule_type']
when "string"
  ## use space separated string
  default['ipf']['pass_icmp']="any"
  default['ipf']['pass_in']=""
  default['ipf']['pass_out']=""
  default['ipf']['block_in']=""
  default['ipf']['block_out']=""
  default['ipf']['ports_block_in']=""
  default['ipf']['ports_pass_in']="22"
  default['ipf']['ports_pass_in_by_ip']=""
  default['ipf']['ports_block_out']=""
  default['ipf']['ports_pass_out']=""
when "array"
  default['ipf']['pass_icmp']=["any"]
  default['ipf']['pass_in']=[]
  default['ipf']['pass_out']=[]
  default['ipf']['block_in']=[]
  default['ipf']['block_out']=[]
  default['ipf']['ports_block_in']=[]
  default['ipf']['ports_pass_in']=["22"]
  default['ipf']['ports_pass_in_by_ip']=[]
  default['ipf']['ports_block_out']=[]
  default['ipf']['ports_pass_out']=[]
end
