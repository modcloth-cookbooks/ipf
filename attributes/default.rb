# Ranges:
# populate the inbound_public_ranges attribute with a
# newline-delimited array of ips

default['ipf']['use_metadata'] = false # add pass_in rule from joyent matadataAPI.
default['ipf']['key_metadata'] = 'ipfilter_pass_in' # only works in array mode.
## example of matadata,conma separated strings ) '192.168.1.0/24,192.168.1.0/24'

## use space separated string, or use array if you want to merge rules by role, environments.
default['ipf']['rules']['pass_icmp'] = 'any'
default['ipf']['rules']['pass_in'] = ''
default['ipf']['rules']['pass_out'] = ''
default['ipf']['rules']['block_in'] = ''
default['ipf']['rules']['block_out'] = ''
default['ipf']['rules']['ports_block_in'] = ''
default['ipf']['rules']['ports_pass_in'] = '22'
default['ipf']['rules']['ports_pass_in_by_ip'] = ''
default['ipf']['rules']['ports_block_out'] = ''
default['ipf']['rules']['ports_pass_out'] = ''
