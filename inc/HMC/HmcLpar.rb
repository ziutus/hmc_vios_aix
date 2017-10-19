require 'HMC/Lpar_profile'

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

    if profile.class.to_s == 'String'
      profile_tmp = Lpar_profile.new
      profile_tmp.parse(profile)
      profile = profile_tmp
    end

    raise 'profile to add is not proper profile object or string with profile' unless profile.class.to_s == 'Lpar_profile'

    @profiles[profile.name]= profile
  end

	def profile_delete(profile_name)
		@profiles.delete(profile_name)
	end

  def profile_exist?(profile_name)
    @profiles.include?(profile_name)
  end

end