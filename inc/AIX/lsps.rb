require 'AIX/lsps_entry'

class Lsps

  attr_reader :data

  def initialize(string)
    @data = {}

    parse(string) unless string.empty?
  end

  def parse(string)

    string.split("\n").each do |line|
      next if line =~ /Page\sSpace\s+Physical\sVolume\s+Volume\sGroup\s+Size\s+%Used\s+Active\s+Auto\s+Type/
      lsps = Lsps_entry.new(line)
      @data[lsps.psname] = lsps
    end
    true
  end
end