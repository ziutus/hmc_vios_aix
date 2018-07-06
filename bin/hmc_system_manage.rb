#! /usr/bin/env ruby

$LOAD_PATH << File.dirname(__FILE__)+'/../inc'
$LOAD_PATH << File.dirname(__FILE__)+'./inc'

require 'optparse'
require 'yaml'
require 'net/ssh'
require 'pp'

require 'Framework/MyExec'
require 'HMC/Sys'

my_name = File.basename(__FILE__)
options = YAML.load_file('hmc_data.yaml')

action = ''
default_action = 'statusAll'
system_name = ''
exec_mode = 'on'

def help_message

  description="
Usage: #{my_name} [opotions]

  -m machine


  possible ACTION:
  on|off - powerOn or powerOff frame or lpar
  status|statusAll - show status of Frame or lpar
  exec on|off - on - run all commands, off - run only commands for collecting data

Examples:
  #{my_name} -a statusAll - show status of all frames (list frames and status)

  "

  puts description
  exit
end

OptionParser.new do |opts|

      ACTION_DESCRIPTION  = "
  possible ACTION:
  on|off - powerOn or powerOff frame or lpar
  status|statusAll - show status of Frame or lpar
  exec on|off - on - run all commands, off - run only commands for collecting data
"

  opts.banner = "Usage: #{my_name} [options] $ACTION_DESCRIPTION"

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

if action == '' || action == nil
  action = default_action
end

if action == 'status' && (system_name == '' || system_name.nil?)
  puts "Action 'status' must follow frame name, as you didn't put name of frame, I'm showing status of all frames action='statusAll'"
  action = 'statusAll'
end

frame = Sys.new(system_name)

$execute = MyExec.new('ssh', exec_mode)
$execute.set_ssh(options[:hmc], options[:username], options[:password])

####
#
####
####
def start_system_and_check_progress(frame_name)

  raise 'missing name of frame' if frame_name.nil?
  pp 'framename:'
  pp frame_name

  frame = Sys.new(frame_name)
  raise 'wrong sys name' if frame.name.nil?

  puts 'Checking status of Frame'
  frame_status = $execute.execute(frame.statusCheck_cmd, 'on').delete("\n")
  puts frame_status.to_s + 'Frame startTime: ' + frame.start_time.to_s

  if frame_status == 'Power Off'
    puts "Frame status is: #{frameStatus}"
    puts 'Starting the frame, will wait ' + frame.start_time.to_s + " seconds"
    $execute.execute(frame.start)
    maxIteration=5
    for i in 1..maxIteration=5
      sleep frame.start_time.to_i
      frame_status = $execute.execute(frame.statusCheck_cmd, 'on').delete("\n")
      break if frame_status == 'Operating'
      puts 'i form: ' + maxIteration.to_s + ' ' + i.to_s
      puts frame_status
    end
  end

  if frame_status == 'Initializing'
    puts 'Frame is starting'
    puts 'Waiting ' + frame.start_time + ' seconds'
    sleep frame.start_time.to_i
  end

  frame_status = $execute.execute(frame.statusCheck_cmd, 'on').delete("\n")
  if frame_status == 'Power Off'
    puts "Can't start the Frame, status of frame " + frame_status
    exit 0
  end
end

puts "HMC: #{options[:hmc]}"
puts "Frame: #{system_name} " if action != 'statusAll'

case action
when 'statusAll'
  puts 'Will check status of frame (All data)'
  puts frame.dataGet
  DataString = $execute.execute(frame.dataGet_cmd)

  frame.decodeString(DataString)

  puts frame.name + ' State:'+frame.state

when 'on'
  puts 'Will power on the frame ' + system_name
  start_system_and_check_progress(system_name)
when 'status'
  puts 'Will check status of frame'
  puts frame.statusCheck
  puts $execute.execute(frame.statusCheck_cmd)
when 'off'
  puts 'Will power off the frame'
  puts frame.stop
  puts $execute.execute(frame.stop_cmd)
else
  print "Illegal command: #{action}\n\n"
end

exit 0