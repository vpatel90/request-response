require_relative '../lib/users.rb'

class ParamAdder
  def initialize(post_body)
    @post_body = post_body
    @users = Users::USERS
  end

  def parse
    return "400 Bad Request" if @post_body.nil?
    str = @post_body.gsub("'", "")
    arr = str.split(",")
    arr2 = arr.map do |item|
      item.split(":")
    end
    arr2.each {|index| index[0] = index[0].to_sym}
    make_name_hash(arr2)
  end

  def make_name_hash(arr2)
    user = Hash[arr2]

    case
    when user[:first_name].nil?, user[:last_name].nil?, user[:age].nil?
      "400 Bad Request"
    else
      add_name_hash(user)
    end
  end

  def add_name_hash(user)
    @users << user
    "201 CREATED \n\n #{user[:first_name]} #{user[:last_name]} #{user[:age]}"
  end

end
