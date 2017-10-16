module HashFromCsv


  def parseCsvToHash (string)

    result = Hash.new
    col_names = Array.new
    line_nb = 0
    string.split("\n").each { |line|
      if line_nb == 0
        col_names = line.split(';')
        line_nb += 1
      else
        cols = line.split(';')

        data = Hash.new

          (0..cols.count-1).each { |i|
            data[col_names[i]] = cols[i]
          }
          result[cols[0]] = data
        line_nb += 1
      end
    }
    result
  end

end