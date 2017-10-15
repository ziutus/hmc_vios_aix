#! /usr/bin/env ruby

require 'optparse'
require 'yaml'
require 'net/ssh'
require 'pp'


require_relative 'inc/nc/MyExec'
require_relative 'inc/HMC/Sys'

myname = File.basename(__FILE__)

options = YAML.load_file('hmc_data.yaml')

action=''
default_action='statusAll'
system_name=''
exec_mode='on'


def help_message

  description="
Usage: #{myname} [opotions]

	-m machine


	possible ACTION:
	exec on|off - on - run all commands, off - run only commands for collecting data

Examples:

	"

  puts description

  exit
end


OptionParser.new do |opts|

  ACTION_DESCRIPTION  = '
	possible ACTION:
	exec on|off - on - run all commands, off - run only commands for collecting data
'

  opts.banner = "Usage: #{myname} [options] $ACTION_DESCRIPTION"


  opts.on('-s', '--hmc NAME',  'server name')            { |v| options[:hmc] = v }
  opts.on('-u', '--username USER', 'user name')          { |v| options[:username] = v }
  opts.on('-p', '--password PASSWORD', 'user password')  { |v| options[:password] = v }
  opts.on('-F', '--frame FRAME', 'frame name')           { |v| system_name = v }
  opts.on('-m', '--machine FRAME', 'frame name')         { |v| system_name = v }
  opts.on('-l', '--lpar LPAR', 'lpar name')              { |v| lpar_name = v }
  opts.on('-E', '--Exec on|off', 'on|off')               { |v| exec_mode = v  }
  opts.on('-a', '--action ACTION  ', 'action ')          { |v| action = v}
  opts.on('-s', '--hmc NAME',          'server name')    { |v| options[:hmc] = v }
  opts.on('-u', '--username USER',     'user name')      { |v| options[:username] = v }
  opts.on('-p', '--password PASSWORD', 'user password')  { |v| options[:password] = v }
  opts.on('-F', '--frame FRAME',       'frame name')     { |v| system_name = v }
  opts.on('-m', '--machine FRAME',     'frame name')     { |v| system_name = v }
  opts.on('-E', '--Exec on|off',       'on|off')         { |v| exec_mode = v  }
  opts.on('-a', '--action ACTION  ',   'action ')        { |v| action = v     }

  opts.on('-h', '--help', 'show this message') do
    puts opts
    exit 1
  end

end.parse!


#puts "action:  " + action.inspect
#puts "execMode:" + execMode.to_s


if action == '' || action == nil
  action = default_action
end

frame = Sys.new(system_name)

execute = execute.new('ssh', exec_mode)
execute = MyExec.new('ssh', exec_mode)
execute.set_ssh(options[:hmc], options[:username], options[:password])

puts "HMC: #{options[:hmc]}"

case action

  when 'ListTaskRoles'
    puts 'Listing Task Roles on HMC'
    HMC = TaskRoles.new()
    TaskRolesList = execute.execute(HMC.getTaskRolesList()).split("\n")
    p TaskRolesList

  when 'TaskRoleAdd'
    puts 'Listing Task Roles on HMC'
    HMC = TaskRoles.new()
    TaskRolesList = execute.execute(HMC.getTaskRolesList()).split("\n")

    Name='test2'

    if TaskRolesList.include? Name
      puts "can't add new taskrole as it exist on this HMC"
    else
      puts 'I will add taskrole to this HMC'
    end

  else
    print "Illegal command: #{action}\n\n"
end

exit 0