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
