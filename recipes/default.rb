include_recipe 'apt'
include_recipe 'hostname'
include_recipe 'core-bits::sshd'
include_recipe 'core-bits::swap'
include_recipe 'core-bits::ntpd'
include_recipe 'core-bits::env'
include_recipe 'core-bits::owner'
include_recipe 'core-bits::syslog'

if node[:hosts]
  node[:hosts].each do |ip, names|
    hostsfile_entry ip do
      ip_address ip
      hostname names[0]
      aliases names[1..-1]
      action :create
    end
  end
end
