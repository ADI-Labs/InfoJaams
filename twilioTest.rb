require 'twilio-ruby'

account_sid = "{{ AC30391f77b8c32bb171c9bccf93a072c3 }}" # Your Account SID from www.twilio.com/console
auth_token = "{{ 0da84d1e8a697cd18be2c28d56d83238 }}"   # Your Auth Token from www.twilio.com/console

begin
    @client = Twilio::REST::Client.new account_sid, auth_token
    message = @client.account.messages.create(:body => "Hey girl how u doin",
        :to => "+19084101220",    # Replace with your phone number
        :from => "+14242834636")  # Replace with your Twilio number
rescue Twilio::REST::RequestError => e
    puts e.message
end
