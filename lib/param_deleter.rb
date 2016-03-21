require_relative '../lib/users.rb'

class ParamDeleter
  attr_accessor :params, :users
  def initialize(params)
    @params = params
    @users = Users::USERS
  end

  def analyze_resource
    if @params[:id].nil?
      "404 not found"
    else
      delete_index
    end
  end

  def delete_index
    require 'pry'; binding.pry
    @users.slice!(@params[:id].to_i - 1)
    "200 OK \n\n"
  end

end
