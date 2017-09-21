$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'pp'
require 'Unix/Ps_process'

class Ps_ef

	attr_reader :table  
	attr_reader :zombies

	def initialize string=""

		@table = Hash.new()
	
		if string.length > 0
			self.decode string 
		end	
	end 
	

	def decode string 
		
		lines = string.split("\n")
		
		lines.each { |string|
				next if string.match("UID\s+PID\s+PPID\s+C\s+STIME\s+TTY\s+TIME\s+CMD")
		
				process =  Ps_process.new(string)
				@table[process.pid] = process 
		}

		@table.keys.each { |key|
			entry = @table[key]
			@table[entry.ppid].children += 1 unless entry.ppid == 0
		} 
		
	end

	def have_more_children	number
		
		array = Array.new()
	
		@table.keys.each { |key|
			next if @table[key].pid == 1 or @table[key].pid == 2
			array << @table[key].pid if @table[key].children > number
		}
		
		array
	end
end