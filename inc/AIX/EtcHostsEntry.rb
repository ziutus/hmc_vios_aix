
require 'pp'

class EtcHostsEntry

	attr_reader :ip
	attr_reader :ip_size
  attr_reader :aliases
  attr_reader :aliases_orig
  attr_reader :name
  attr_reader :valid
  attr_reader :errors
  attr_reader :errors_list
  attr_reader :corrected

	attr_accessor :break_size
	
	def initialize( ip, name, aliases)

		@ip = ip
		@name = name 
		@aliases = aliases 
		@break_size=3
		@ip_size=ip.size

		@aliases_orig = aliases 
		
		@corrected = false
		
		self.validate
	end 

	def validate

		aliases_tmp =  @aliases_orig.split(' ')

		aliases_tmp.sort!
		aliases_tmp.uniq!
		aliases_tmp.delete(@name)
		
		@aliases = aliases_tmp.join(' ')

		@corrected = true if  (@aliases != @aliases_orig) 
		
	end 
	
	def to_s
		result_s = @ip 
		
		for i in 1..break_size
			result_s << ' '
		end 

		result_s << @name
		result_s << ' '
		result_s << @aliases
		
		result_s
	end

end