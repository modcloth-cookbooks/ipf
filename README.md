ipf
===

Configures ipfilter on SmartOS.  attributes/default.rb contains null attributes that, if populated, will create block/pass rules in /etc/ipf/ipf.conf

You can make use of override attributes in roles, etc. for more granular control of ipfilter rules across your infrastructure.

As an example, here's how you can allow traffic from any RFC 1918 address, as well as traffic from the newline-delimited list of IP ranges used by Cloudflare when accessing your endpoint.

    override_attributes(
      "ipf" => {
        "pass_in" => `curl -s https://www.cloudflare.com/ips-v4`.gsub(/\n/," ").split + ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]
      }
    )

By default, the ipf cookbook allows only incoming traffic on port 22 (ssh) and allows all outgoing traffic.

(optional)Array mode
----

You can choose a rule format from string and array.

If you want to format as array, set`['ipf']['rule_type']="array"`

And set rules as array to an attribute following...

    ['ipf']['pass_icmp']=["any"]
    ['ipf']['pass_in']=["10.0.0.0/8","192.168.0.0/24"]
 
### addition pass_in rule from metadata

Notice: This feature depends on `cookbook[smartmachine_functions]` `~>0.5.0`.

If you set `['ipf']['use_metadata'] = ture`. The chef will get additional rules from the joyent metadataAPI.  
This rules will merge to pass_in rule.

A default key is `ipfilter_pass_in`. It can overriden at  `['ipf']['key_metadata']`.

**Metadata example**
    "ipfilter_pass_in" : "192.168.1.0/24,192.168.1.0/24"

