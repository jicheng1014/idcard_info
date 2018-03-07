require "idcard_operation/version"
require_relative './idcard_operation/idcard_info'
require_relative './idcard_operation/roc_idcard_info'

module IdcardOperation
  class << self
    def analysis(idcard)
      if idcard.length == 18
        IdcardInfo.new(idcard)
      else
        RocIdcardInfo.new(idcard)
      end
    end
  end
end
