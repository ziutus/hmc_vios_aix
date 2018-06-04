$LOAD_PATH << File.dirname(__FILE__)+"./inc"
$LOAD_PATH << File.dirname(__FILE__)

require 'pp'
require 'Unix/Ps_process'

class Ps_ef

  attr_reader :table
  attr_reader :zombies

  def initialize(string = '')
    @table = {}

    decode(string) unless string.empty?
  end

  def decode(string)
    string.split("\n").each do |string|
      next if string =~ /"UID\s+PID\s+PPID\s+C\s+STIME\s+TTY\s+TIME\s+CMD"/

      process = Ps_process.new(string)
      @table[process.pid] = process
    end

    @table.each_key do |key|
      entry = @table[key]
      @table[entry.ppid].children += 1 unless entry.ppid == 0
    end
  end

  def have_more_children(number)
    array = []

    @table.each_key do |key|
      next if @table[key].pid == 1 || @table[key].pid == 2
      array << @table[key].pid if @table[key].children > number
    end

    array
  end
end