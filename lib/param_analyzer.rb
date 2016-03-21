require_relative '../lib/users.rb'

class ParamAnalyzer
  attr_accessor :params
  def initialize(params)
    @params = params
  end

  def analyze_resource
    if @params[:resource] == "users"
      if @params.size == 3
        puts get_users
        puts
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
      if Users::USERS[@params[:id].to_i].nil?
        "404 User not found \n\n"
      else
        get_user_at_id
      end
    end
  end

  def get_all_users
    user_names = ["Response Code 200 OK\n\n"]
    Users::USERS.each do |user|
      user_names << "First Name: #{user[:first_name]} Last Name: #{user[:last_name]} Age: #{user[:age]} \n"
    end
    return user_names
  end

  def get_user_at_id
    user_names = ["Response Code 200 OK\n\n"]
    user = Users::USERS[@params[:id].to_i]
    user_names << "First Name: #{user[:first_name]} Last Name: #{user[:last_name]} Age: #{user[:age]} \n"
    return user_names
  end

  def analyze_optional_params

  end
end
