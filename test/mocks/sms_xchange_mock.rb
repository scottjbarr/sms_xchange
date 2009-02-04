#
# A mock of the SmsXchange class
#

# require the real class
require 'lib/sms_xchange'

# reopen and override the class
class SmsXchange
  
  def send(phone, message)
    # raise an Exception = "Message not sent. Undocumented error."
    raise Exception.new(get_error_message("05"))
  end
  
end
