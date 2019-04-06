o = node[:owner]
username = o[:username]
home_dir = "/home/#{username}"
ssh_dir = "#{home_dir}/.ssh"

user username do
  password o[:password]
  home home_dir
  shell '/bin/zsh'
  manage_home true
end

template '/etc/sudoers' do
  owner 'root'
  group 'root'
  mode 0440
  source 'sudoers.erb'
end

directory ssh_dir do
  owner username
  group username
  mode 00700
  action :create
end

file "#{ssh_dir}/authorized_keys" do
  owner username
  group username
  mode 00600
  content ::File.open('/root/.ssh/authorized_keys').read
  action :create_if_missing
end

template "#{home_dir}/.zshrc" do
  source 'zshrc.erb'
end

template "#{home_dir}/.tmux.conf" do
  source 'tmux.conf.erb'
end
