# A facter fact to determine the DNS domain name
#

module Facter::Util::DnsDomainName
  class << self
    def get_domain
      Facter::Util::Resolution.exec("/bin/hostname -d")
    end
  end
end

Facter.add(:dns_domain_name) do
  setcode { Facter::Util::DnsDomainName.get_domain }
end
