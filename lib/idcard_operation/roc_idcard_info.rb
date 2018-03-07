# frozen_string_literal: true
# 台湾国民身份证校验

class RocIdcardInfo
  attr_accessor :idcard, :gender, :location, :valid
  def initialize(idcard)
    self.idcard = idcard.upcase
    return unless valid?

    self.valid = valid?

    self.gender = idcard[1] == "1" ? "男" : "女"
    self.location = location_dict[idcard[0]].first
  end

  def valid?
    return false unless /^[A-Z]\d{9}$/.match?(idcard)
    check
  end

  def to_hash
    instance_variables.map do |var|
      [var[1..-1].to_sym, instance_variable_get(var)]
    end.to_h
  end
  alias to_h to_hash
  
  private

  def check
    tmp = [1,9,8,7,6,5,4,3,2,1,1]
    sum = 0
    "#{location_dict[idcard[0]].last}#{idcard[1..-1]}".split('').each_with_index do |item, index|
      sum += item.to_i * tmp[index]
    end
    sum % 10 == 0
  end

  def char_to_calc_int
    # ascII 码 - 55
    idcard[0].upcase.ord - 55
  end

  def location_dict
    {
      'A' => ['台北市', 10],
      'B' => ['台中市', 11],
      'C' => ['基隆市', 12],
      'D' => ['台南市', 13],
      'E' => ['高雄市', 14],
      'F' => ['台北县', 15],
      'G' => ['宜兰县', 16],
      'H' => ['桃园县', 17],
      'I' => ['嘉义市', 34],
      'J' => ['新竹县', 18],
      'K' => ['苗栗县', 19],
      'L' => ['台中县', 20],
      'M' => ['南投县', 21],
      'N' => ['彰化县', 22],
      'O' => ['新竹市', 35],
      'P' => ['云林县', 23],
      'Q' => ['嘉义县', 24],
      'R' => ['台南县', 25],
      'S' => ['高雄县', 26],
      'T' => ['屏东县', 27],
      'U' => ['花莲县', 28],
      'V' => ['台东县', 29],
      'W' => ['金门县', 32],
      'X' => ['澎湖县', 30],
      'Y' => ['阳明山管理局', 31],
      'Z' => ['连江县', 33]
    }
  end
end
