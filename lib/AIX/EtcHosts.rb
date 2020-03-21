class EtcHosts

# file /etc/hosts 
# check if line has entry about serverIP and name of sevrer (alias)
# if exist, modify, if not exist add 
# (remove only if whole file should be managed by this script and not puppet/chef etc...)


# etc_host_entry 
# ipv4_address name alias1 alias2 
# ipv6_address name alias1 alias2 

#	attr_reader :name, :physloc 
	attr_accessor :DataString 
	attr_accessor :ip_size_max #max size of IP address, it is for bettter print table in file 
	
	def initialize string=''

		@DataString = string
		
	end 

	def check hostLine
	
		#build tables of entries
		#check also duplicates!
	
		return false
	end

end