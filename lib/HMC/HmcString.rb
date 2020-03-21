module HmcString

  def parse(string)

    my_result = {}
    key = ''
    value = ''
    inside_index = 1
    insite_quotation_mark = 0

    i = 0
    while i < string.length

      if string[i] == '"' && string[i + 1] == '"'
        i += 2
        value << '""'
        next
      end

      if string[i] == '"' && string[i + 1] != '"'
        insite_quotation_mark.zero? ? insite_quotation_mark = 1 : insite_quotation_mark = 0
        i += 1
        next
      end

      if string[i] == ',' && insite_quotation_mark.zero?
        my_result[key] = value
        key = ''
        value = ''
        inside_index = 1
        i += 1
        next
      end

      if string[i] == '=' && inside_index == 1
        inside_index = 0
        i += 1
        next
      end

      inside_index == 1 ? key << string[i] : value << string[i]
      i += 1
    end
    my_result[key]= value # last key and value (loop is ended as we haven't last ",")
    my_result
  end

  def parse_value(string)
    i = 0
    insite_quotation_mark = 0
    value = ''
    array = []

    while i < string.length
      if string[i] == '"' && string[i + 1] == '"'
        insite_quotation_mark.zero? ? insite_quotation_mark = 1 : insite_quotation_mark = 0
        i += 2
        next
      end

      if string[i] == ',' && insite_quotation_mark.zero?
        array.push(value)
        value = ''
        i += 1
        next
      end

      value << string[i]
      i += 1
    end

    array.push(value)
    array
  end

  def make_string(parameter, string)

    unless string.nil?
      string = parameter + '=' + string
      if string.include?('"') || string.include?(',')
        string = '"' + string + '"'
      end
    end

    string
  end
end