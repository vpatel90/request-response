require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/param_analyzer'


class TestParamAnalyzer < Minitest::Test

  def test_param_init
    params = {:resource=>"users", :id=>nil, :action=>nil}
    @param_analyzer = ParamAnalyzer.new(params)
    assert params, @param_analyzer.params
  end


end
