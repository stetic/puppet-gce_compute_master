# A facter fact to determine the DNS domain name
#

module Facter::Util::GceProjectId
  class << self
    def get_project_id
      Facter::Util::Resolution.exec("/usr/share/google/get_metadata_value project-id")
    end
  end
end

Facter.add(:gce_project_id) do
  setcode { Facter::Util::GceProjectId.get_project_id }
end
