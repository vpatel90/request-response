require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/param_analyzer'
require_relative 'test_users'



class TestParamAnalyzer < Minitest::Test

  def test_param_init
    params = {:resource=>"users", :id=>nil, :action=>nil}
    param_analyzer = ParamAnalyzer.new(params)
    assert params, param_analyzer.params
  end

  def test_get_user_at_id
    params = {:resource=>"users", :id=>1, :action=>nil}
    param_analyzer = ParamAnalyzer.new(params)
    param_analyzer.users = TestUsers::USERS
    expected = ["Response Code 200 OK\n\n", "First Name: Abby Last Name: Hunter Age: 26 \n"]
    assert_equal(expected, param_analyzer.get_user_at_id)
  end

  def test_user_not_found
    params = {:resource=>"users", :id=>9999, :action=>nil}
    param_analyzer = ParamAnalyzer.new(params)
    param_analyzer.users = TestUsers::USERS
    expected = "404 User not found \n\n"
    assert_equal(expected, param_analyzer.get_users)
  end

end
