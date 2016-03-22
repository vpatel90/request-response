require_relative '../lib/users.rb'

class ParamAdder
  def initialize(post_body)
    @post_body = post_body
    @users = Users::USERS
  end

  def parse
    str = @post_body.gsub("'", "")
    str = "{#{str}}"
    add_name_hash(str)
  end

  def add_name_hash(str)
    @users << eval(str)
    "200 OK \n\n"
  end

end
