require_relative '../lib/users.rb'

class ParamModifier
  def initialize(post_body, id)
    @post_body = post_body
    @users = Users::USERS
    @id = id
  end

  def parse
    return "404 not found" if @id.nil?
    str = @post_body.gsub("'", "")
    str = "{#{str}}"
    evaluate(str)
  end

  def evaluate(str)
    hash = eval(str)
    user = @users[@id.to_i - 1]
    case
    when hash.has_key?(:age)
      user[:age] = hash[:age]
    when hash.has_key?(:first_name)
      user[:first_name] = hash[:first_name]
    when hash.has_key?(:last_name)
      user[:last_name] = hash[:last_name]
    end
    "200 OK \n\n #{user[:first_name]} #{user[:last_name]} #{user[:age]}"
  end

end
