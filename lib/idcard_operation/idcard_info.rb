require 'yaml'
class IdcardInfo
  attr_accessor :idcard, :valid, :gender, :birthday, :main_location, :location_raw, :name, :name_valid

  def initialize(idcard)
    @@dict ||= YAML.safe_load(File.read(File.expand_path('../../../geo_info.yml', __FILE__)))
    @@provinces_standard ||= %w[北京市 天津市 河北省 山西省 内蒙古自治区 辽宁省 吉林省 黑龙江省 上海市 江苏省 浙江省 安徽省 福建省 江西省 山东省 河南省 湖北省 湖南省 广东省 广西壮族自治区 海南省 重庆市 四川省 贵州省 云南省 西藏自治区 陕西省 甘肃省 青海省 宁夏回族自治区 新疆维吾尔自治区 台湾省 香港特别行政区 澳门特别行政区].freeze
    self.idcard = idcard
    self.valid = valid_idcard?
    return unless valid

    self.birthday = calc_birthday
    self.gender = calc_gender
    self.location_raw = @@dict["geoinfo"][idcard[0..5].to_i]
    self.main_location = format_province(location_raw)
  end

  def format_province(province)
    answer = @@provinces_standard.find do |goal|
      /^#{goal}/.match? province
    end
    return answer unless answer.nil?

    answer || province
  end

  def calc_gender
    idcard[-2].to_i % 2 == 1 ? "男" : "女"
  end

  def calc_birthday
    Date.new(idcard[6..9].to_i, idcard[10..11].to_i, idcard[12..13].to_i)
  end

  def valid_idcard?
    self.class.valid_idcard?(idcard)
  end

  def to_hash
    instance_variables.map do |var|
      [var[1..-1].to_sym, instance_variable_get(var)]
    end.to_h
  end
  alias to_h to_hash

  class << self
    def valid_idcard?(idcard_no)
      return false unless /\d{17}([0-9]|x|X)/.match?(idcard_no)
      sysbit(idcard_no).downcase == idcard_no[-1]&.downcase
    end

    private

    def sysbit(idcard_no)
      sum = 0
      idcard_no[0..-2].split('').each_with_index do |bit, i|
        sum += bit.to_i * weight(18 - i)
      end
      office_bit.at(sum.divmod(11).last)
    end
  
    def weight(i)
      (2**(i - 1)).divmod(11).last
    end
  
    def office_bit
      %w[1 0 x 9 8 7 6 5 4 3 2]
    end
  end
end
