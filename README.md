# ipf cookbook

Configures ipfilter on SmartOS.  `attributes/default.rb` contains null
attributes that, if populated, will create block/pass rules in
`/etc/ipf/ipf.conf`.

You can make use of override attributes in roles, etc. for more granular
control of ipfilter rules across your infrastructure.

As an example, here's how you can allow traffic from any RFC 1918
address, as well as traffic from the newline-delimited list of IP ranges
used by Cloudflare when accessing your endpoint.

``` ruby
cloudflare_ips = `curl -s https://www.cloudflare.com/ips-v4`.split(/[\n\s]/)
override_attributes(
  'ipf' => {
    'pass_in' => cloudflare_ips + ['10.0.0.0/8', '192.168.0.0/16', '172.16.0.0/12']
  }
)
```

By default, the ipf cookbook allows only incoming traffic on port 22
(ssh) and allows all outgoing traffic.


## Rule setting specifics

You can specify rules as either strings or arrays.  Setting node
attributes as arrays looks like this:

``` ruby
override_attributes(
  'ipf' => {
    'pass_icmp' => ['any'],
    'pass_in' => ['10.0.0.0/8', '192.168.0.0/24']
  }
)
```

The benefit of using arrays is that Chef attribute inheritance works as
expected.
 
### Additional `pass_in` attributes

**NOTE**: This feature depends on `cookbook[smartmachine_functions]` `~> 0.5.0`.

If you set `['ipf']['use_metadata'] = true`, the Chef context will get
additional rules from the Joyent metadata API via the attribute
specified in `node['ipf']['key_metadata']`.  These rules will be merged
into the `pass_in` rule attribute.

The default key used is `ipfilter_pass_in`, which can overridden at
`['ipf']['key_metadata']`.  The key is fetch from the JSON output of a
call to `SmartMachine::Metadata.from_metadata` such as:

``` javascript
// ...
  "ipfilter_pass_in": "192.168.1.0/24,192.168.1.0/24"
// ...
```
