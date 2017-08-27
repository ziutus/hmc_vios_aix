require 'pp'
require 'Targetcli/TargetcliBase'

class Backstore < TargetcliBase

	attr_accessor :type 
	attr_accessor :name, :path, :size, :write, :status 

	def initialize 
		super 
	end	


end