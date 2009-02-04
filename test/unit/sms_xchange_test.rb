require 'test/test_helper'

# unit test will be working against the mock
require 'test/mocks/sms_xchange_mock'

class SmsXchangeTest < Test::Unit::TestCase

  def setup
    @client = SmsXchange.new(:username => "scott", :password => "pass1")
    @phone = "6597528429"
    @message = "Test message"
  end
  
  def test_default_server
    assert_equal SmsXchange::SERVER, @client.server
  end
  
  def test_get_url
    url = @client.get_url()
    
    assert_equal "https", url.scheme
    assert_equal "www.smsxchange.com", url.host
    assert_equal "/scripts/sendsms.asp", url.path
  end
  
  def test_get_data
    expected = "userid=scott&password=pass1&phone=6597528429&sms=Test+message"
    assert_equal expected, @client.get_data(@phone, @message)
  end
  
  def test_authentication_details
    assert_equal "scott", @client.username
    assert_equal "pass1", @client.password
  end
  
  def test_send
    assert_raise Exception do
      @client.send("6597529999", "This is a test message")
    end
  end
  
  def test_get_error_message
    expected = "Gateway application response code 02 - No Such User"
    assert_equal expected, @client.get_error_message("02")
  end
  
end
