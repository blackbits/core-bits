directory '/var/log' do
  user 'root'
  group 'syslog'
  mode 0755
end

pattern = '\/var\/log\/syslog'
path = '/etc/logrotate.d/rsyslog'
create = 'create 640 syslog adm'

execute "add 'create 640 syslog adm' to rsyslog logrotate" do
  command "sed -i -E '/#{pattern}/{N;s/(#{pattern}\\n\\{)/\\1\\n\\t#{create}/}' #{path}"
  not_if "grep '#{create}' #{path}"
end
