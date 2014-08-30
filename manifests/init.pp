# Class: gce_compute_master
#
# This class installs a Puppet master for community edition
#
# Parameters:
#
# Actions:
#   - Configure master settings
#   - Install Puppet master
#   - Enable and start Puppet master service
#
# Requires:
#
# Sample Usage:
# 
class gce_compute_master {

  $dns_domain = $::dns_domain_name
  $project_id = $::gce_project_id

  Ini_setting {
    path    => '/etc/puppet/puppet.conf',
    ensure  => present,
  }
  
  ini_setting { 'puppet-conf-main-server':
    section => 'main',
    setting => 'server',
    value   => "puppet-master.${dns_domain}",
  }
  ->
  ini_setting { 'puppet-conf-master-autosign':
    section => 'master',
    setting => 'autosign',
    value   => true,
  }
  ->
  ini_setting { 'puppet-conf-master-ssl_client_header':
    section => 'master',
    setting => 'ssl_client_header',
    value   => 'SSL_CLIENT_S_DN',
  }
  ->
  ini_setting { 'puppet-conf-master-ssl_client_verify_header':
    section => 'master',
    setting => 'ssl_client_verify_header',
    value   => 'SSL_CLIENT_VERIFY',
  }
  ->
  file { '/etc/puppet/autosign.conf':
    ensure  => file,
    path    => '/etc/puppet/autosign.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "*.${dns_domain}"
  }
  ->
  file { '/etc/puppet/device.conf':
    ensure  => file,
    path    => '/etc/puppet/device.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "[${project_id}]
type gce
url [/dev/null]:${project_id}"
  }
  ->
  package { "puppetmaster":  
    ensure  => present
  }
  ->
  service { "puppetmaster":  
    ensure  => running
  }

}