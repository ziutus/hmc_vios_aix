class HmcLpar

	attr_accessor :sys
  attr_accessor :name
  attr_accessor :lpar_name
	attr_accessor :hmcs

	attr_reader :profiles

	def initialize(lpar_id)
	
		@lpar_id  = lpar_id
    @profiles = Hash.new
	end

  def profile_add(profile)
    @profiles[profile.name]= profile
  end

	def profile_delete(profile_name)
		@profiles.delete(profile_name)
	end

  def profile_exist?(profile_name)
    @profiles.include?(profile_name)
  end

end