# Puppet module for Open Source Puppet Master on Google's Compute Engine


This module is an addition to the official [Puppet for Google Compute Engine module](https://github.com/puppetlabs/puppetlabs-gce_compute)
and installs a Open Source Puppet master.

To use this module you have to add it in the module_repos section and add ```include gce_compute_master``` to the manifest of your instance.


### Example manifest

```puppet
gce_instance { 'puppet-master':
  ensure                => present,
  description           => 'Puppet Master Open Source',
  machine_type          => 'f1-micro',
  zone                  => 'us-central1-a',
  network               => 'default',
  auto_delete_boot_disk => false,
  tags                  => ['puppet', 'master'],
  image                 => 'projects/debian-cloud/global/images/backports-debian-7-wheezy-v20140814',
  manifest              => "include gce_compute_master",
  startupscript         => 'puppet-community.sh',
  puppet_service        => present,
  puppet_master         => "puppet-master",
  modules               => ['puppetlabs-gce_compute', 'puppetlabs-inifile', 'puppetlabs-stdlib', 'puppetlabs-apt', 'puppetlabs-concat', 'saz-locales'],
  module_repos          => { 
    'gce_compute_master' => 'git://github.com/stetic/puppet-gce_compute_master'
  }
}
```
