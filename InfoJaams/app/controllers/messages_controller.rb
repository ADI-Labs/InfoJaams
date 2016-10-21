class MessagesController < ApplicationController
 skip_before_filter :verify_authenticity_token
 #skip_before_filter :authenticate_user!, :only => "reply"

  def reply
    account_sid = 'ACf4ffde17e6c54016acef9309e1c69bcc'
    auth_token = '44a85afbed6a67013e46198132f8232f'
    @client = Twilio::REST::Client.new account_sid, auth_token
    message_body = params["Body"]
    from_number = params["From"]
    sms = @client.messages.create(
      from: '+16267747914',
      to: from_number,
      body: "Hello there, thanks for texting me. Your number is #{from_number}."
    )

  end
end
