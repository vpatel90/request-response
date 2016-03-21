require_relative '../lib/users.rb'

class ParamAnalyzer
  attr_accessor :params, :users
  def initialize(params)
    @params = params
    @users = Users::USERS
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
      if @users[@params[:id].to_i].nil?
        "404 User not found \n\n"
      else
        get_user_at_id
      end
    end
  end

  def get_all_users
    user_names = ["Response Code 200 OK\n\n"]
    @users.each do |user|
      user_names << "First Name: #{user[:first_name]} Last Name: #{user[:last_name]} Age: #{user[:age]} \n"
    end
    return user_names
  end

  def get_user_at_id
    user_names = ["Response Code 200 OK\n\n"]
    user = @users[@params[:id].to_i]
    user_names << "First Name: #{user[:first_name]} Last Name: #{user[:last_name]} Age: #{user[:age]} \n"
    return user_names
  end

  def analyze_optional_params
    "its getting here"
  end
end
