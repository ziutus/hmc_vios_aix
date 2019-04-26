require 'HMC/lssvcenevents_entry'

# Fantastic class to analyze events from HMCs
class Lssvcevents
  attr_reader :events
  attr_reader :errors

  def initialize(string = nil, hmc_name = nil)
    @events = []
    @errors = []

    parse(string, hmc_name) unless string.nil?
  end

  def parse(string, hmc_name)
    return true if string =~ /^No results were found./

    if string =~ /An unknown error occurred while trying to perform this command. Retry the command. If the error persists, contact your software support representative/
      @errors.push(hmc: hmc_name, error: 'An unknown error occurred while trying to perform this command. Retry the command. If the error persists, contact your software support representative')
      return true
    end

    string.split("\n").each do |line|
      entry = Lssvcenevents_entry.new(line, hmc_name)

      if @events.count.zero?
        @events.push(entry)
        next
      end

      exist_in_events = false
      event_id = 0
      @events.each_with_index do |event, id|
        if event.compare(entry)
          event_id = id
          exist_in_events = true
          break
        end
      end

      if exist_in_events
        @events[event_id].hmc_add(hmc_name)
      else
        @events.push(entry)
      end
    end

    true
  end

  def count
    @events.count
  end
end