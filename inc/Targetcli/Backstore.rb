require 'pp'
require 'Targetcli/TargetcliBase'

class Backstore < TargetcliBase

  attr_accessor :type
  attr_accessor :name
  attr_accessor :path
  attr_accessor :size
  attr_accessor :write
  attr_accessor :status

  def initialize
    super
  end

end