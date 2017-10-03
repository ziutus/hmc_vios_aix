require "pp"

class HmcLpar

	attr_reader :sys, :dataString, :name, :lpar_name

	def initialize sys, lpar_name, lpar_id
	
		@sys       = sys 
		@lpar_name = lpar_name
		@lpar_id   = lpar_id 
	end


end