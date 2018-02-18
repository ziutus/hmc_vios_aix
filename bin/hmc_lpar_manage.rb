#! /usr/bin/env ruby

require 'optparse'
require 'yaml'
require 'net/ssh'
require 'pp'


require_relative 'inc/nc/MyExec'
require_relative 'inc/HMC/Sys'
require_relative 'inc/HMC/Lpar_real'
require_relative 'inc/HMC/Lpar_profile'

require_relative 'inc/HMC/VirtualEthAdapter'
require_relative 'inc/HMC/VirtualScsiAdapter'

require_relative 'inc/HMC/TaskRoles'

my_name = File.basename(__FILE__)

options = {}
options = YAML.load_file('hmc_data.yaml')

action=''
default_action='statusAll'
system_name=''
lpar_name=''
lpar_id=0
exec_mode='on'


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

  opts.banner = "Usage: #{myName} [options] $ACTION_DESCRIPTION"
  opts.banner = "Usage: #{my_name} [options] $ACTION_DESCRIPTION"


  opts.on('-s', '--hmc NAME',  'server name') { |v| options[:hmc] = v }
  opts.on('-u', '--username USER', 'user name') { |v| options[:username] = v }
  opts.on('-p', '--password PASSWORD', 'user password') { |v| options[:password] = v }
  opts.on('-F', '--frame FRAME', 'frame name') { |v| system_name = v }
  opts.on('-m', '--machine FRAME', 'frame name') { |v| system_name = v }
  opts.on('-l', '--lpar LPAR', 'lpar name') { |v| lpar_name = v }
  opts.on('-i', '--lparID LPARID', 'lpar id') { |v| lpar_id = v }
  opts.on('-E', '--Exec on|off', 'on|off') { |v| exec_mode = v  }

  opts.on('-a', '--action ACTION  ', 'action ') { |v|
    action = v
  }
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

if action == 'status' and (system_name == '' or system_name == nil)
  puts "Action 'status' must follow frame name, as you didn't put name of frame, I'm showing status of all frames action='statusAll'"
  action = 'statusAll'
end

frame = Sys.new(system_name)

execute = execute.new('ssh', exec_mode)
execute = MyExec.new('ssh', exec_mode)
execute.set_ssh(options[:hmc], options[:username], options[:password])

####
#
####
####



#puts "lpar: #{lparName} "

puts "HMC: #{options[:hmc]}"

case action
  when 'on'
    action='lparOn'
  when 'off'
    action='lparOff'
end


case action

  when 'lparOn'

    lpars = lpar_name.split(',')

    lpars.each do |lpar|
      puts "lpar to check #{lpar}"

      lpar_id=execute.execute(frame.findLparID(lpar), 'on')

      STDERR.puts "Checking the lparID of #{lpar}"
      if lpar_id.match('HSCL8012')
        puts "The lpar #{lpar} doesn't exist on Frame #{system_name}, exiting..."
        exit 3
      end
      lpar_id=lpar_id.gsub("\n",'')
      STDERR.puts "lpar ID of lpar #{lpar} is #{lpar_id}"

      lpar_real = Lpar_real.new(system_name, lpar_id, lpar)
      puts execute.execute(lpar_real.start('normal'))
    end

  when 'lparMemoryAdd'
    lpar = Lpar_real.new(system_name, lpar_id, lpar_name)
    puts execute.execute(lpar.memoryAdd_cmd(1024))

  when 'lparMemoryRemove'
    lpar = Lpar_real.new(system_name, lpar_id, lpar_name)
    puts execute.execute(lpar.memoryRemove_cmd(1024))

  when 'lparProcUnitsRemove'
    lpar = Lpar_real.new(system_name, lpar_id, lpar_name)
    puts execute.execute(lpar.procUnitsRemove_cmd(0.1))

  when 'lparProcUnitsAdd'
    lpar = Lpar_real.new(system_name, lpar_id, lpar_name)
    puts execute.execute(lpar.procUnitsAdd_cmd(0.1))


  when 'lparAddVscsi'
    lpar = Lpar_real.new(system_name, lpar_id, lpar_name)
    puts execute.execute(lpar.vscsiAdd(2, lpar_id, 2))
    puts execute.execute(lpar.vscsiAdd(3, lpar_id, 3))

  when 'lparOff'

    lpars = lpar_name.split(',')

    lpars.each do |lpar|

      lpar_id=execute.execute(frame.findLparID(lpar), 'on')

      STDERR.puts "Checking the lparID of #{lpar}"
      if lpar_id.match('HSCL8012')
        puts "The lpar #{lpar} doesn't exist on Frame #{system_name}, exiting..."
        exit 3
      end
      lpar_id=lpar_id.gsub("\n",'')
      STDERR.puts "lpar ID of lpar #{lpar} is #{lpar_id}"


      lpar = Lpar_real.new(system_name, lpar_id, lpar)
      puts execute.execute(lpar.stop())
    end

  when 'lparRemove'
    lpar = Lpar_real.new(system_name, lpar_id, lpar_name)
  #puts Exec.Exec(lpar.lparRemove())


  when 'lparCreate'
    puts 'Moved to separate file'

  when 'checkVIOS'

    puts 'Will check real (current) slot configuration for VIOS'
    puts ' *Getting list of lpars on Frame (lparName and ID)'
    String1 = execute.execute(frame.getLparsList(), 'on')
    array = Hash.new()
    lpars = Hash.new()

    String1.split("\n").each { |line|
      (index, value) = line.split(',')
      array[index.to_i]=value
      lpars[index.to_i]= Lpar_real.new(system_name, index, value)
    }

    puts ' -Getting VIOS virtual slot configuration'
    puts ' --getting vscsi adapters'
    puts ''

    Adapters =  execute.execute(frame.getLparsScsiSlots(), 'on')

    slotsUsed = Hash.new{ |h,k| h[k] = Hash.new(&h.default_proc) }

    Adapters.split("\n").each { |line|

      regExp = /lpar_name=([\w\-\_]+),lpar_id=(\d+),(.*)/
      match = regExp.match(line)
      abort "RegExp couldn't decode string #{line}" unless match

      adapter = VirtualScsiAdapter.new()
      adapter.decode(match[3])

      slotsUsed[match[2].to_i][adapter.virtualSlotNmuber] = 'notUsed'

      lpars[match[2].to_i].adapter_scsi_add(adapter)
    }

    lpars.keys.each { |lparID|
      #lpar is VIOS, so let's check if remote lpar exist
      lpars[lparID].virtual_scsi_adapters.keys.each { |adapterID|

        lparRemoteID = lpars[lparID].virtual_scsi_adapters[adapterID].remoteLparID
        slotRemoteID = lpars[lparID].virtual_scsi_adapters[adapterID].remoteSlotNumber

        slotLocal  = lpars[lparID].virtual_scsi_adapters[adapterID]

        next if ( slotLocal.clientOrServer == 'server' )

        if (lpars.key?(lparRemoteID.to_i))
          if ( lpars[lparRemoteID.to_i].virtual_scsi_adapters.key?(slotRemoteID.to_i))
            slotsUsed[lparRemoteID.to_i][slotRemoteID.to_i] = 'Used'
            slotsUsed[lparID.to_i][adapterID.to_i] = 'Used'
          end
        end
      }
    }

    puts 'report of SCSI slots using '
    puts 'Exec mode:' + exec_mode

    slotsUsed.each  do | key, value|
      #puts "lparID: " + key.to_s
      slotsUsed[key].each do | key2, value2 |
        #pp "lparID: " + key.to_s + ' slot ' + key2.to_s + ' value ' + slotsUsed[key][key2]
        next if slotsUsed[key][key2] == 'Used'
        puts lpars[key].slotRemove(key2)
      end
    end

    #
    puts 'checking profiles'
    profiles = Hash.new{ |h,k| h[k] = Hash.new(&h.default_proc) }
    String2 = execute.execute(frame.getProfiles(), "on")
    String2.split("\n").each do  |line|
      #puts "Profile " + line

      regExp = /name=([\w\-\_]+),lpar_name=([\w\-\_]+),lpar_id=(\d+),(.*)/
      match = regExp.match(line)
      abort "RegExp couldn't decode string #{line}" unless match

      #puts "profile:" + match[1]
      #puts "lpar   :" + match[2]
      #puts "lparID :" + match[3]
      #puts "string :" + match[4]
      #puts ""

      # sys, lpar_name, lpar_id, name='normal'
      #	profile = Lpar_profile.new(frame, match[2], match[3], match[1])
      #	profile.lssyscfgProfDecode(line)
      #	profiles[match[2]][match[1]] = profile

    end

  else
    print "Illegal command: #{action}\n\n"
end


