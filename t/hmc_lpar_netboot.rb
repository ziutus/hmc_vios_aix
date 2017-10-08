$LOAD_PATH << File.dirname(__FILE__) + '/../inc'
$LOAD_PATH << File.dirname(__FILE__) + './inc'
$LOAD_PATH << File.dirname(__FILE__)

require 'HMC/lpar_netboot'
require 'test/unit'
require 'pp'

class TestHMCLpar < Test::Unit::TestCase
 
  
	def test_lpar_netboot_1
		
		netboot = Lpar_netboot.new()
		
		netboot.machine 	  = '9131-52A-6535CCG'
		netboot.lpar_name 	  = 'aix61_3'
		netboot.lpar_profile  = 'normal'
		netboot.verbose 	  = 'on'
		netboot.spanning_tree = 'off'
		netboot.virtual_terminal_close = 'on'
		netboot.all = 'on'
		netboot.ping_test = 'on'
		netboot.lpar_speed = 'auto'
		netboot.lpar_duplex = 'auto'
		netboot.nim_ip = '192.168.200.235'
		netboot.lpar_gateway = '192.168.200.1'
		netboot.lpar_ip = '192.168.200.241'
		
		string = 'lpar_netboot -A -C 192.168.200.241 -d auto -D -f -G 192.168.200.1 -s auto -S 192.168.200.235 -t ent -T off -v aix61_3 normal 9131-52A-6535CCG'
		
#		pp string 
#		pp netboot.cmd() 
		
		assert_equal(string, netboot.cmd)
	end
	
end	