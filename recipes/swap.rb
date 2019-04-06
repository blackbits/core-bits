if node[:swapfile][:enabled]
  bash 'swapfile' do
    # https://www.digitalocean.com/community/articles/how-to-add-swap-on-ubuntu-12-04
    file = node[:swapfile]
    path = file[:path]
    mbs = file[:size] || node[:memory][:total].to_i / 1000
    code <<-EOH
      dd if=/dev/zero of=#{path} bs=1024 count=#{mbs}k
      mkswap #{path}
      swapon #{path}
      echo "#{path} swap swap sw 0 0 " >> /etc/fstab
      echo 0 | tee /proc/sys/vm/swappiness
      echo vm.swappiness = 10 | tee -a /etc/sysctl.conf
      chown root:root #{path}
      chmod 0600 #{path}
    EOH
    not_if { ::File.exists? path }
  end
end
