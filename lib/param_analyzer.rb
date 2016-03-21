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
        "404 not found \n\n"
      else
        get_user_at_id
      end
    end
  end

  def get_all_users
    user_names = ["200 OK\n\n"]
    @users.each do |user|
      user_names << "First Name: #{user[:first_name]} Last Name: #{user[:last_name]} Age: #{user[:age]} \n"
    end
    return user_names
  end

  def get_user_at_id
    user_names = ["200 OK\n\n"]
    user = @users[@params[:id].to_i - 1]
    user_names << "First Name: #{user[:first_name]} Last Name: #{user[:last_name]} Age: #{user[:age]} \n"
    return user_names
  end

  def analyze_optional_params
    if @params[:first_name].nil?
      get_users_at_range
    else
      get_users_with_first_name
    end
  end

  def get_users_with_first_name
    user_names = ["200 OK\n\n"]
    first_names = @users.map { |hash| hash[:first_name] }
    requested_names = first_names.select {|names| names.match(/#{@params[:first_name].capitalize}/)}
    @users.each do |user|
      if requested_names.any? {|name| name == user[:first_name]}
        user_names << "First Name: #{user[:first_name]} Last Name: #{user[:last_name]} Age: #{user[:age]} \n"
      end
    end
    return user_names
  end

  def get_users_at_range
    start_index = @params[:limit].to_i - 1
    total_length = start_index + @params[:offset].to_i
    if total_length > @users.size - 1
      "404 not found \n\n"
    else
      user_names = ["200 OK\n\n"]
      (start_index...total_length).each do |index|
        user = @users[index]
        user_names << "First Name: #{user[:first_name]} Last Name: #{user[:last_name]} Age: #{user[:age]} \n"
      end
      return user_names
    end
  end
end
