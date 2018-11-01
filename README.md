# ohai-plugin-amazon-provided-dns

Ohai plugin to get the AmazonProvidedDNS IP address from the EC2 meta-data

# Usage

## ohai command

```console
# VPC CIDR = 10.0.0.0/16
$ ohai -d /path/to/plugin/dir/ | jq .amazon_provided_dns
{
  "ip": "169.254.169.253",
  "vpc_ip": "10.0.0.2"
}
```

## chef

```ruby
# (client|solo).rb
Ohai::Config[:plugin_path] << '/path/to/plugins'
```

```ruby
# in cookbook
node[:amazon_provided_dns][:ip]
node[:amazon_provided_dns][:vpc_ip]
```
