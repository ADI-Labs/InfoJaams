class MessagesController < ApplicationController
 skip_before_filter :verify_authenticity_token
 #skip_before_filter :authenticate_user!, :only => "reply"

  def reply
    account_sid = 'ACf4ffde17e6c54016acef9309e1c69bcc'
    auth_token = '44a85afbed6a67013e46198132f8232f'
    @client = Twilio::REST::Client.new account_sid, auth_token
    message_body = params["Body"]
    BingSearch.account_key = 'HBqI/Aby4J6YoPBqgXHNTcvSoQzfXdrmDTykSeoBb0U'
    message = ""
    results = BingSearch.web(message_body,limit: 5)
    count = 1
    results.each do |r|
      puts r.title
      puts r.summary
      puts r.url
      puts count
      message += r.title + r.summary + r.url
      count += 1
    end
    from_number = params["From"]
    sms = @client.messages.create(
      from: '+16267747914',
      to: from_number,
      body: "Hello there, thanks for texting me." + message
    )
  end


end
