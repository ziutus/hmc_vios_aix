class Vhost

	#see: https://www.ibm.com/support/knowledgecenter/en/POWER8/p8hcg/p8hcg_lsmap.htm
	
	attr_accessor :name, :physloc, :client_partition_id, :vtds
	attr_reader :client_partition_id_nice
	
	def initialize string='' 
		
		@vtds = Array.new()
		
		if string.length > 0
#		  @data_string_raw = string
		  self.parse(string)
		end			
	end
	
	def decode string
		regExp =  %r{^\s*(vhost\d+)\s+([\.\-\w]+)\s+(0x\w+)\s*$}

		if match = regExp.match(string)
			@name 				 = match[1]
			@physloc 			 = match[2]
			@client_partition_id = match[3]
			@client_partition_id_nice = Integer(match[3])
			#.to_f.convert_base(16)
		else 
			raise "Class:VIOS:Vhost, function: parse, RegExp couldn't decode string >>#{string}<<"
		end
	end

	def vtds_add string
		@vtds.push(string)
	end
	
	alias :parse :decode
end