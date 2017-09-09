module HmcString

  def parse(string)

    myResult = Hash.new()
    key = ''
    value = ''
    insideIndex = 1
    insiteQuotationMark = 0

    string.each_char do |c|

      if c == '"'
        insiteQuotationMark ==0 ? insiteQuotationMark =1 : insiteQuotationMark = 0
        next
      end

      if c == "="
        if insideIndex == 1
          insideIndex = 0
        else
          insideIndex = 1
        end
        next
      end

      if c == ',' and insiteQuotationMark == 0
        myResult[key]= value
        key = ''
        value = ''
        insideIndex = 1
        next
      end

      if insideIndex == 1
         key << c
      else
        value << c
      end

    end

    myResult[key]= value #last key and value (loop is ended as we haven't last ",")

    myResult

  end

end