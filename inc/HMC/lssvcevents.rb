
require 'HMC/lssvcenevents_entry'

class Lssvcevents

  attr_reader :events

  def initialize(string = nil, hmc_name = nil)
    @events = Array.new

    self.parse(string, hmc_name) unless string.nil?
  end

  def parse(string, hmc_name)

    return true if   '^No results were found.'.match(string)

    string.split("\n").each { |line|
      @events.push(Lssvcenevents_entry.new(line, hmc_name))
    }


    return true
  end

  def count
    @events.count
  end

end