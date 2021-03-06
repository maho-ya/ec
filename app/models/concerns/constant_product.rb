module ConstantProduct
  extend ActiveSupport::Concern

  # 最大値
  MAXIMUM_SALES_PRICE = 99_999_999
  MAXIMUM_REGULAR_PRICE = 99_999_999
  MAXIMUM_NUMBER_OF_STOCKS = 99_999_999
  # 最小桁数
  MINIMUM_NAME = 2
  # 最大桁数
  MAXIMUM_NAME = 40
  MAXIMUM_MANUFACTURE_NAME = 40
  MAXIMUM_CODE = 32
  MAXIMUM_DESCRIPTION = 1000
  MAXIMUM_SEARCH_TERM = 40
  MAXIMUM_JAN_CODE = 32
end
