class RuleNumber
  attr_reader :number, :tokens

  def initialize(number)
    @number = number
    @tokens = []
    @token_index = 0
    parse number
  end

  def to_s
    number.to_s
  end

  def <=>(other)
    len = [tokens.length, other.tokens.length].min - 1
    for i in 0..len
      result = 0
      if is_numeric(tokens[i], other.tokens[i])
        result = compare_numeric(tokens[i], other.tokens[i])
      elsif is_roman(tokens[i], other.tokens[i])
        result = compare_roman(tokens[i], other.tokens[i])
      elsif is_lower(tokens[i], other.tokens[i])
        result = compare_lower(tokens[i], other.tokens[i])
      else
        result = -1 if tokens[i] < other.tokens[i]
        result =  1 if tokens[i] > other.tokens[i]
      end
      return result if result != 0
    end
    return tokens.length <=> other.tokens.length
  end

  private

  def parse(src)
    pos = 0
    len = src.length
    while pos < len 
      char = src[pos]
      pos += 1

      case char
      when /\d/
        append char
      when /[\.\-\s\)\#]/
        add_token
      when '('
        add_token
      else
        append char
      end
    end
    evaluate
  end

  def add_token
    return if !@tokens[@token_index] || @tokens[@token_index] == ""
    evaluate
    @token_index += 1
  end

  def append(char)
    if !@tokens[@token_index] then
      @tokens[@token_index] = ""
    end
    @tokens[@token_index] << char
  end

  def evaluate
    return if !@tokens[@token_index]
    @tokens[@token_index].strip!
  end

  def roman_mapping
    {
      1000 => "m",
      900 => "cm",
      500 => "d",
      400 => "cd",
      100 => "c",
      90 => "xc",
      50 => "l",
      40 => "xl",
      10 => "x",
      9 => "ix",
      5 => "v",
      4 => "iv",
      1 => "i"
    }
  end

  def to_arabic(str)
    result = 0
    roman_mapping.values.each do |roman|
      while str.start_with?(roman)
        result += roman_mapping.invert[roman]
        str = str.slice(roman.length, str.length)
      end
    end
    result
  end

  def is_roman(a, b)
    a =~ /^[cdilmvx]+$/ && b =~ /^[cdilmvx]+$/
  end

  def compare_roman(a, b)
    val_a = to_arabic(a)
    val_b = to_arabic(b)
    return -1 if val_a < val_b
    return  1 if val_a > val_b
    return 0
  end

  def is_lower(a, b)
    a =~ /^[a-z]+$/ && b=~ /^[a-z]+$/
  end

  def alpha
    'abcdefghijklmnopqrstuvwxyz'
  end

  def lower_value(str)
    val = 0
    for i in 0..str.length - 1
      char = str[i - 1]
      charval = alpha.index(char) + 1
      val += charval * (26 ** (str.length - i))
    end
    val
  end

  def compare_lower(a, b)
    lower_value(a) <=> lower_value(b)
  end

  def is_numeric(a, b)
    a =~ /^\d+$/ && b =~ /^\d+$/
  end

  def compare_numeric(a, b)
    return -1 if a.to_i < b.to_i
    return  1 if a.to_i > b.to_i
    return 0
  end
end
