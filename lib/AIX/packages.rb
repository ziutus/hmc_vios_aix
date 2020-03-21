require 'AIX/package'

class Packages

  attr_reader :list

  def initialize(string)

    @list = Hash.new
    @data_string_raw=''


    if string.length > 0
      @data_string_raw = string
      self.parse(string)
    end
  end

  def parse(string)

    string.each_line do |line|
      package = Package.new(line)
      @list[package.fileset] = package
    end
  end

end