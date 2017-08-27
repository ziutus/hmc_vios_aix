require 'pp'

class Lpar_netboot

	attr_accessor :all 			# -A 
	attr_accessor :ipv6 		# -a
	attr_accessor :image_boot 	# -B Image_filename
	attr_accessor :lpar_ip 		# -C Client
	attr_accessor :ping_test	# -D
	attr_accessor :lpar_duplex  # -d duplex
	attr_accessor :virtual_terminal_close # -f 
	attr_accessor :lpar_gateway # -G gateway
	attr_accessor :nim_ip		# -S server  
	attr_accessor :lpar_speed   # -s  speed 
	attr_accessor :spanning_tree # -T 
	attr_accessor :verbose		# -v 
	
	attr_accessor :lpar_name, :lpar_profile, :machine
	
	def initialize
		
		@lpar_speed  = "auto"
		@lpar_duplex = "auto"
	end 


	def cmd
	
		# mandatory parameters
		raise "not defined machine" 		unless @machine
		raise "not defined lpar profile" 	unless @lpar_profile
		raise "not defined lpar name"		unless @lpar_name 
	
		### Validation of parameters 
	    #
		duplex_allowed = [ "half", "full", "auto" ]
		raise "not allowed value for -D duplex settings: #{@lpar_duplex} " unless duplex_allowed.include?(@lpar_duplex) 
	
		spanning_tree_allowed = [ "on", "off"]
		raise "not allowed value for -T option (spanning tree): #{@spanning_tree}" unless spanning_tree_allowed.include?(@spanning_tree)
	
		### building command string 
		string  = "lpar_netboot"
	
		# Returns all adapters of the particular type that are specified with the -t flag.
		string += " -A" if @all == "on"

		#Specifies the IP address of the partition to start the network.
		string += " -C " + @lpar_ip.to_s 

		#Specifies the duplex setting of the partition that is specified with the -C flag. 
		#The valid values for the -d flag are full, half, and auto.
		string += " -d " + @lpar_duplex.to_s
		
		
		#Performs a ping test to identify and use the adapter that can successfully 
		#ping the server that is specified with the -S flag.
		string += " -D" if @ping_test == "on" 

		#Force closes a virtual terminal session for the partition.
		string += " -f" if @virtual_terminal_close == "on"

		#Specifies the gateway IP address of the partition that is specified with the -C flag.
		string += " -G " + @lpar_gateway.to_s 
		
		#Specifies the speed setting of the partition that is specified with the -C flag.
		string += " -s " + @lpar_speed.to_s

		#Specifies the IP address of the partition, from which to retrieve the network boot image during network boot.	
		string += " -S " + @nim_ip.to_s 
		
		
		#Specifies the type of adapter for displaying the MAC address or physical location code discovery, 
		#or for network boot. The only valid value for the -t flag is ent for Ethernet.
		string += " -t ent"
		
		#Enables or disables the display of the firmware-spanning tree. The valid values for the -d flag are on and off.
		if @spanning_tree == "on"		
			string += " -T on"
		else 
			string += " -T off"
		end 	

		#Enables or disables the display of the firmware-spanning tree. The valid values for the -d flag are on and off.
		string += " -v" if @verbose == "on" 

		# last parameters
		string += " " + @lpar_name.to_s + " " + @lpar_profile.to_s + " " + @machine.to_s	
		
		return string 
	end

end