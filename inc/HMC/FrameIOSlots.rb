require 'pp'
require 'HMC/FrameIOSlot'

class FrameIOSlots

	attr_reader :data_string_raw
	
	def initialize string='' 

		@array = Array.new()
		
		if string.length > 0
		  @data_string_raw = string
		  self.parse(string)
		end			
	end
		
	def parse string

		string.each_line { |line|
				@array <<  FrameIOSlot.new(line)
		}
	
	end

	def get_lpar lpar

		@array.each { |slot|
			
			#if lpar == slot.lpar_name
				##pp  slot.lpar_name.to_s + " " + slot.description
			#end	
		}
	
	end

	
end