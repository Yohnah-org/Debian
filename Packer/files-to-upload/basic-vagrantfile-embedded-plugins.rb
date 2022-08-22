#VAGRANT-BEGIN
# Add commands to vagrant cli to manage the kubernetes box. DO NOT MODIFY

class ListIPs < Vagrant.plugin(2, :command)
  def self.synopsis
    "List configured IP addresses and network interfaces on the guest machine"
  end
  def execute
    opts = OptionParser.new do |o|
      o.banner = "Usage: vagrant showIPs"
      o.separator ""
      o.separator "Example:"
      o.separator "$ vagrant showIPs"
      o.separator ""
      o.separator "Options:"
      o.separator ""
    end

    argv = parse_options(opts)
    return if !argv

    with_target_vms(nil, single_target: true) do |vm|
      env = vm.action(:ssh_run, ssh_run_command: "get-ips.sh", tty: false,)
      status = env[:ssh_run_exit_status] || 0
    end

  end
end

class Plugin < Vagrant.plugin("2")
  name "List IP Addresses"
  description "List IP Addresses"
  command "list-ips" do
    ListIPs
  end
end
#VAGRANT-END