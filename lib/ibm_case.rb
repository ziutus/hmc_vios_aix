require 'pp'

class IbmCase

  attr_accessor :country_code
  attr_accessor :country_name
  attr_accessor :branch_id
  attr_reader :type #(pmr, rcms or poject)
  attr_reader :id
  attr_reader :phm
  attr_reader :rcms


  def initialize(case_id)

      id = case_id.gsub(',', '.')
      @id = id
      self.decode()

  end

  def rcms?
    return true if self.type == 'rcms'
    false
  end

  def pmr?
    return true if self.type == 'rcms'
    false
  end

  def project?
    return true if self.type == 'project'
    false
  end

  # -pmr      transfer is for a PMR problem
  #                         -id references a PMR id, provided by IBM support
  #                         format: ppppp.bbb.ccc
  #                         p: PMR number   b: branch id  c: country code

  # -rcms     transfer is for a RCMS problem
  #                         -id references a RCMS id, provided by IBM support
  #                         format: rrrrrrr.ccc
  #                         r: RCMS number  c: country code

  def decode()

    if match = %r{^(\w{3})(\w{7})$}.match(@id) #website ID format
      @country_code = match[1]
      @rcms         = match[2]
      @type         = 'rcms'
    elsif match2 = %r{^(\w{7})\.(\w{3})$}.match(@id)
      @rcms         = match2[1]
      @country_code = match2[2]
      @type = 'rcms'
    elsif match = %r{^(\w{5})\.(\w{3})\.(\w{3})$}.match(@id)
      @phm          = match[1]
      @branch_id    = match[2]
      @country_code = match[3]
      @type = 'pmr'
    elsif match = %r{^(\w{5})$}.match(@id)
      @phm  = match[1]
      @type = 'pmr'
    else
      pp @id
      raise 'wrong id, it is not rcms or pmr'
    end

  end

  def validate
    unless @type == 'pmr' or @type == 'rcms' or @type == 'project'
      raise 'wrong type'
    end

    if @type == 'pmr'
      raise 'not setup phm'          if @phm.nil?
      raise 'not setup branch_id'    if @branch_id.nil?
      raise 'not setup country_code' if @country_code.nil?
    end

    if @type == 'rcms'
      raise 'not setup rcms'          if @rcms.nil?
      raise 'not setup country_code' if @country_code.nil?
    end


  end


  def id_nice
    self.validate


    if (@type == 'rcms')
      return @rcms + '.' + @country_code
    elsif (@type == 'pmr')
      return  @phm  + '.' + @branch_id  + '.' + @country_code
    end
  end

  def to_ibmsdduu
    self.validate

    '-' + @type + " -id=" + self.id_nice
  end

end