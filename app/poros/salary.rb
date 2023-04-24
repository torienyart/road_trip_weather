require 'action_view'
include ActionView::Helpers::NumberHelper

class Salary
  attr_reader :title, :min, :max

  def initialize(salary_info)
    @title = salary_info[:job][:title]
    @min = format_min(salary_info[:salary_percentiles][:percentile_25])
    @max = format_max(salary_info[:salary_percentiles][:percentile_75])
  end

  def format_min(min_number)
    number_to_currency(min_number, precision: 2)
  end

  def format_max(max_number)
    number_to_currency(max_number, precision: 2)
  end
end