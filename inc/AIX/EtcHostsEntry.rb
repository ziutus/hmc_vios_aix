
require "pp"

class EtcHostsEntry

	attr_reader :ip, :ip_size, :aliases, :aliases_orig, :name, :valid, :errors, :errors_list, :corrected 
	attr_accessor :break_size
	
	def initialize( ip, name, aliases)

		@ip = ip
		@name = name 
		@aliases = aliases 
		@break_size=3
		@ip_size=ip.size

		@aliases_orig = aliases 
		
		@corrected = false
		
		self.validate()	
	end 

	def validate

		aliases_tmp =  @aliases_orig.split(" ")

		aliases_tmp.sort!
		aliases_tmp.uniq!
		aliases_tmp.delete(@name)
		
		@aliases = aliases_tmp.join(" ") 

		@corrected = true if  (@aliases != @aliases_orig) 
		
	end 
	
	def to_s
		result_s = @ip 
		
		for i in 1..break_size
			result_s << " "
		end 

		result_s << @name
		result_s << " "
		result_s << @aliases
		
		return result_s 
	end

end