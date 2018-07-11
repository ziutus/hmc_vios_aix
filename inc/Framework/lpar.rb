require 'Framework/HmcLpar'

class Lpar < HmcLpar

  attr_accessor :npiv
  attr_accessor :vscsi

  def initialize(sys = nil, lpar_id = nil, name = nil, hmc = nil)

    super(sys, lpar_id, name, hmc)

    @npiv = {}
    @vscsi = {}
  end

  def do_something_for_git

  end
end