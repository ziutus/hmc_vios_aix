require "pp"

class HmcLpar

	attr_accessor :sys, :name, :lpar_name
	attr_accessor :hmcs
	attr_reader :profiles

	def initialize lpar_id
	
		@lpar_id   = lpar_id
	end

  def add_profile profile
    @profiles.push(profile)
  end

end