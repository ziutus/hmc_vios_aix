class DataFile3

	def initialize(fileName, comment = nil)
		@fileName  = fileName

		unless File.exist?(fileName)
			File.open(@fileName, 'a') { |file|
				file.write("### file format:3.0 ###\n")
			}

			unless comment.nil?
				File.open(@fileName, 'a') { |file|
					file.write("### comment:#{comment} ###\n")
				}
			end
		end

	end

	def Write command, value

		File.open(@fileName, 'a') { |file|
			file.write("### command:#{command} ### time:#{Time.now.strftime("%Y-m-d_%H:%M:%S")} ### timestamp: #{Time.now.to_i} ###\n")
			file.write(value) 
		}
	end

	def ListCommands

		result = Hash.new

		file = File.new(@fileName, 'r')
		while (line = file.gets)
			if match = /### command: (.*) ### time:(.*) ### timestamp: (\d+) ###/.match(line)
				result[match[1]] = Array.new if result[match[1]].nil?
				result[match[1]].push(match[3])
			end
		end

		result
	end

	def Read command 

		result = Hash.new
		insiteCommand=0
		timestamp = nil

		file = File.new(@fileName, 'r')
		while (line = file.gets)

			if match = /### command: (.*) ### time:(.*) ### timestamp: (\d+) ###/.match(line)
				match[1] == command ? insiteCommand=1 : insiteCommand=0
				timestamp = match[3]
				next
			end

			if insiteCommand == 1
				if result[timestamp].nil?
					result[timestamp] = line.gsub("\r", '')
				else
					result[timestamp] += line.gsub("\r", '')
				end
			end
		end
		file.close	

		result
	end

end	
