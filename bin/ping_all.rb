#! /usr/bin/env ruby
$LOAD_PATH << File.dirname(__FILE__)+ '/lib'

# standard libraries
require 'pp'
require 'optparse'
require 'net/ping'
require 'dnsruby'
include Dnsruby


my_name = File.basename(__FILE__)

# own functions
def up?(host)
    check = Net::Ping::External.new(host)
    check.ping?
end

def ip (server)
	resolver = Dnsruby::DNS.new
	ip=''

  if  server =~ %r{\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}}
    begin
        ip =  resolver.getname(server)
    rescue Exception => e
      ip = 'DNS query failed'
    end

  else
    begin
        ip =  resolver.getaddress(server)
    rescue Exception => e
      ip = 'DNS query failed'
    end
  end

	return ip
end


def strMax (string, length)
	(string + ' ' * length)[0, length]
end



# variablies
status_ok     = 0
status_failed = 0

arr = Array.new()

options = {}
servers = []
serverLengthMax=0
ipsLengthMax=0

pingResults =  {}
ips = []

serverString=''
regexp = nil

#parsing command line options
optparse = OptionParser.new do |opts|

	opts.banner = 'This script ping in the same time many servers and provide result in nice way'
	
    opts.on('-s', '--server SERVER[,SERVER]', 'SERVER for test ping') do |server|
		serverString += server + "," 
	end
  
	opts.on_tail('-h', '--help', 'Display this screen') do
		puts opts
		exit
	end 
 
	opts.on('-f', '--filename FILENAME', 'FILENAME with list of servers to test') do |fileName|
	 		file = File.new(fileName, 'r')
			while (line = file.gets)
				serverString += line + ','
			end
			file.close
  end

  opts.on('-e', '--regexp REGEXP', 'regexp to take only some servers from list') do |string|
  	regexp = string
  end
end  

begin
	optparse.parse!
end	

serverString.gsub!("\n",'')
serverString.gsub!("\r",'')

servers = serverString.split(',')

servers.uniq! #removing duplicates 

unless regexp.nil?
  servers_tmp = servers
  servers = []
  servers_tmp.each { |server|
    servers.push(server) if server =~ /#{regexp}/i
  }
end

if servers.empty?
	puts ''
	puts 'No servers to ping!'
	puts "Try #{my_name} -h"
	exit
end 

puts "Will check status of #{servers.count.to_s} servers "
puts ''

numbers = [*0..servers.count-1]

numbers.each {|i|

    ips[i] = ip(servers[i]).to_s   
   
    arr[i] = Thread.new {
        
	  result = up?(servers[i])
	   
      Thread.current['result'] =  result.to_s
	  
	  result ? status_ok +=1 :  status_failed+=1
	  
   }
}


serverLengthMax = servers.max_by(&:length).length
ipsLengthMax    = ips.max_by(&:length).length

numbers.each {|i|

	t = arr[i] 
	t.join
	
	puts strMax(servers[i], serverLengthMax) + strMax( ' (' + ips[i] + ') ', ipsLengthMax+4) + t['result']
	
}

puts "\nservers=" + servers.size.to_s + "; ok=#{status_ok}; failed=#{status_failed}"

exit 0