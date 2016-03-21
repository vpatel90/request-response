require_relative '../lib/users.rb'

class ParamAnalyzer
  attr_accessor :params
  def initialize(params)
    @params = params
  end

  def analyze_resource
    if @params[:resource] == "users"
      if @params.size == 3
        get_users
      else
        analyze_optional_params
      end
    else
      ##other resource
    end
  end

  def get_users
    if @params[:id].nil?
      get_all_users
    else

    end
  end

  def get_all_users
    puts "Response Code 200 OK\n\n"
    Users::USERS.each do |user|
      puts "First Name: #{user[:first_name]} Last Name: #{user[:last_name]} Age: #{user[:age]} \n"
    end
  end
  def analyze_optional_params

  end
end
