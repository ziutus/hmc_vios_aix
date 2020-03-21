#! /usr/bin/env ruby
$LOAD_PATH << File.dirname(__FILE__) + '/../../lib'

# standard libraries
require 'pp'
require 'optparse'
# require 'erb'

# own libraries
require 'Framework/DataFile3'
require 'Linux/df'

base_dir = '/tmp/'

date = Time.now.strftime("%Y%m%d")
verbose = 1
fsToReport = []
percent_min = 10

OptionParser.new do |opts|

  opts.on('--dir BASE_DIR', 'base dir for all reports') { |v| base_dir = v }
  opts.on('--date YYYMMDD-HHMM', 'date of report') { |v| date = v }
  opts.on('--percent PERCENT', 'percent to report') { |v| percent_min = v.to_i }
end.parse!

dir = "#{base_dir}/#{date}/Linux/"

unless Dir.exist?(dir)
  puts "Expected directory #{dir} doesn't exist."
end

Dir[ dir + '/*.datafile.txt'].sort.each do |filename|

  puts "Checking file #{filename}" if verbose > 0
  file = DataFile3.new(filename)

  uname_n = file.read_simple('uname -n').strip

  data_string = file.read_simple('df -P --local')

  df = Df.new(data_string, uname_n)

  df.table.each_key  do | filesystem |
    if df.table[filesystem].used_percent.to_i > percent_min
      fsToReport.push(df.table[filesystem])
    end
  end

end


if fsToReport.count > 0
  puts '<table>'
  puts '<tr><th>System</th><th>filesystem</th><th>size</th><th>used</th><th>avialable</th><th>used %</th><th>mounted on</th></tr>'

  fsToReport.each do |fs|
    puts  '<tr>'
    puts  '<td>' + fs.system + '</td>'
    puts  '<td>' + fs.filesystem + '</td>'
    puts  '<td>' + fs.size + '</td>'
    puts  '<td>' + fs.used + '</td>'
    puts  '<td>' + fs.available + '</td>'
    puts  '<td>' + fs.used_percent + '</td>'
    puts  '<td>' + fs.mounted_on + '</td>'
    puts '</tr>'
  end
  puts '</table>'
end

exit fsToReport.count