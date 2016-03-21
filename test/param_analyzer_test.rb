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
    params = {:resource=>"users", :id=>2, :action=>nil}
    param_analyzer = ParamAnalyzer.new(params)
    param_analyzer.users = TestUsers::USERS
    expected = ["200 OK\n\n", "First Name: Abby Last Name: Hunter Age: 26 \n"]
    assert_equal(expected, param_analyzer.get_user_at_id)
  end

  def test_user_not_found
    params = {:resource=>"users", :id=>9999, :action=>nil}
    param_analyzer = ParamAnalyzer.new(params)
    param_analyzer.users = TestUsers::USERS
    expected = "404 not found \n\n"
    assert_equal(expected, param_analyzer.get_users)
  end

  def test_users_with_first_name
    params = {:resource=>"users", :id=>9999, :action=>nil, :first_name=>"s"}
    param_analyzer = ParamAnalyzer.new(params)
    param_analyzer.users = TestUsers::USERS
    expected = ["200 OK\n\n", "First Name: Sally Last Name: Sitwell Age: 46 \n"]

    assert_equal(expected, param_analyzer.get_users_with_first_name)
  end

  def test_get_users_at_range_404
    params = {:resource=>"users", :id=>9999, :action=>nil, :limit=>"15", :offset=>"6"}
    param_analyzer = ParamAnalyzer.new(params)
    param_analyzer.users = TestUsers::USERS
    assert_equal("404 not found \n\n", param_analyzer.get_users_at_range)
  end

  def test_get_users_at_range_get_first
    params = {:resource=>"users", :id=>9999, :action=>nil, :limit=>"1", :offset=>"1"}
    param_analyzer = ParamAnalyzer.new(params)
    param_analyzer.users = TestUsers::USERS
    expected = ["200 OK\n\n", "First Name: Vivek Last Name: Patel Age: 26 \n"]
    assert_equal(expected, param_analyzer.get_users_at_range)
  end

end
