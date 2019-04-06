include_recipe 'zsh'
include_recipe 'vim'
include_recipe 'tmux'

template '/etc/environment' do
  source 'environment.erb'
  variables env: node[:env]
end
