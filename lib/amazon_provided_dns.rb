require 'net/http'

def get_amazon_provided_dns_ip
  dns = {}

  metadata_base_ip = "169.254.169.254"

  mac_addr = Net::HTTP.get(metadata_base_ip, "/latest/meta-data/mac")
  vpc_cidr = Net::HTTP.get(metadata_base_ip, "/latest/meta-data/network/interfaces/macs/#{mac_addr}/vpc-ipv4-cidr-block")
  ip = vpc_cidr.split("/")[0]
  splited_ip = ip.split(".")
  splited_ip[3] = splited_ip[3].to_i + 2

  dns[:ip] = splited_ip.join(".")

  dns
end

def create_objects
  amazon_provided_dns Mash.new(get_amazon_provided_dns_ip)
end

Ohai.plugin(:AmazonProvidedDNS) do
  provides 'amazon_provided_dns'

  collect_data(:linux) do
    create_objects
  end
end
