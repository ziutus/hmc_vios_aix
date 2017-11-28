class DataFile3

	def initialize(fileName)
		@fileName  = fileName 
	end

	def CheckCommands

		file = File.new(@fileName, "r")
		while (line = file.gets)

			regexp=Regexp.new("###command:(.*)###")
		
		end
		file.close	
	
	end

	def Write command, value
		File.open(@fileName, 'a') { |file| 
			file.write("###command:#{command}###\n")
			file.write(value) 
		}
		#file.close
	end 

	def Read command 
		dataString = ""; 
		regexpCommand=Regexp.new(Regexp.escape(command))
		regexp=Regexp.new("###command")
		insiteCommand=0
		
		file = File.new(@fileName, "r")
		while (line = file.gets)
#			puts line 
			matchCommand = regexpCommand.match(line)
			match = regexp.match(line)
			
			if match and matchCommand
#				puts "found!!!"
#				puts match
				insiteCommand=1
				next 
			elsif match 
#				puts "new command: #{line}"
				insiteCommand=0
			end	
			
			if insiteCommand == 1
				line.gsub!("\r", '')
				dataString << line 
			end
			
		end
		file.close	

		dataString 		
	end
	

end	
