require 'net/http'
require 'net/https'
require 'cgi'

class SmsXchange
  
  OK = "01"
  
  ERRORS = {
    "02" => "No Such User",
    "03" => "Password is wrong",
    "04" => "Domain Name of server is wrong",
    "05" => "Message not sent. Undocumented error.",
    "06" => "Phone Number is empty.",
    "07" => "SMS parameter missing. No message to send.",
    "09" => "Insufficient SMS Credits."
  }
  
  SERVER = "https://www.smsxchange.com"
  URL = "/scripts/sendsms.asp"
  PARAMS = "userid=%s&password=%s&phone=%s&sms=%s"
  
  attr_reader :username, :password, :server
  
  def initialize(opts)
    @server = opts[:server] || SERVER
    @username = opts[:username]
    @password = opts[:password]
  end
  
  #
  # Get the data to send to the service
  #
  def get_data(phone, message, test = false)
    sprintf(PARAMS, @username, @password, CGI.escape(phone), CGI.escape(message))
  end
  
  #
  #
  # Get the url for the service
  def get_url
    URI.parse("#{@server}#{URL}")
  end
  
  def get_error_message(code)
    sprintf "Gateway application response code %s - %s", code, ERRORS[code] || "Unknown error code"
  end
  
  #
  # Send an sms message
  #
  def send(phone, message)
    url = get_url
    url.query = get_data(phone, message, test)
    
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = (url.scheme == 'https')
    
    res = https.get(url.request_uri)
    
    if res.code.to_i != 200
      raise Exception.new("Server responded with HTTP " + res.code)
    end
    
    if res.body != OK
      raise Exception.new(get_error_message(res.body))
    end
  end
  
end
