require_relative '../db/setup'
require_relative '../lib/users.rb'
require_relative '../lib/param_analyzer'
require_relative '../lib/param_deleter'
require_relative '../lib/param_adder'
require_relative '../lib/param_modifier'
# Remember to put the requires here for all the classes you write and want to use

def parse_params(uri_fragments, query_param_string)
  params = {}
  params[:resource]  = uri_fragments[3]
  params[:id]        = uri_fragments[4]
  params[:action]    = uri_fragments[5]
  if query_param_string
    param_pairs = query_param_string.split('&')
    param_k_v   = param_pairs.map { |param_pair| param_pair.split('=') }
    param_k_v.each do |k, v|
      params.store(k.to_sym, v)
    end
  end
  params
end
# You shouldn't need to touch anything in these methods.
def parse(raw_request)
  pieces = raw_request.split(' ')
  method = pieces[0]
  uri    = pieces[1]
  http_v = pieces[-1]
  post_body = pieces[-2] if pieces.size > 3
  route, query_param_string = uri.split('?')
  uri_fragments = route.split('/')
  protocol = uri_fragments[0][0..-2]
  full_url = uri_fragments[2]
  subdomain, domain_name, tld = full_url.split('.')
  params = parse_params(uri_fragments, query_param_string)
  return {
    method: method,
    uri: uri,
    http_version: http_v,
    protocol: protocol,
    subdomain: subdomain,
    domain_name: domain_name,
    tld: tld,
    full_url: full_url,
    post_body: post_body,
    params: params
  }
end

system('clear')
loop do
  print "Supply a valid HTTP Request URL (h for help, q to quit) > "
  raw_request = gets.chomp

  case raw_request
  when 'q' then puts "Goodbye!"; exit
  when 'h'
    puts "A valid HTTP Request looks like:"
    puts "\t'GET http://localhost:3000/students HTTP/1.1'"
    puts "Read more at : http://www.w3.org/Protocols/rfc2616/rfc2616-sec5.html"
  else
    @request = parse(raw_request)
    @params  = @request[:params]
    # Use the @request and @params ivars to full the request and
    # return an appropriate response

    # YOUR CODE GOES BELOW HERE
    case @request[:method]
    when "GET"
      puts ParamAnalyzer.new(@params).analyze_resource
    when "DELETE"
      puts ParamDeleter.new(@params).analyze_resource
    when "POST"
      puts ParamAdder.new(@request[:post_body]).parse
    when "PUT"
      puts ParamModifier.new(@request[:post_body],@params[:id]).parse
    else
      puts "405 Method Not Allowed"
    end
    # YOUR CODE GOES ABOVE HERE  ^
  end
end
