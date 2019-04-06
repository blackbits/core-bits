service 'ssh' do
  if 'ubuntu' == node[:platform] &&
     Chef::VersionConstraint.new('>= 15.04').include?(node[:platform_version])
    provider Chef::Provider::Service::Systemd
  else
    provider Chef::Provider::Service::Upstart
  end

  supports :restart => true
  action [:enable, :start]
end

ssh_config 'Port' do
  string "Port #{node[:ssh][:port]}"
end

ssh_config 'PermitRootLogin' do
  string 'PermitRootLogin without-password'
end

ssh_config 'PasswordAuthentication' do
  string 'PasswordAuthentication no'
end

ssh_config 'PermitEmptyPasswords' do
  string 'PermitEmptyPasswords no'
end

ssh_config 'AllowUsers' do
  string "AllowUsers #{node[:owner][:username]}"
end

ssh_config 'UseDNS' do
  string 'UseDNS no'
end

ssh_config 'UsePAM' do
  string 'UsePAM yes'
end
