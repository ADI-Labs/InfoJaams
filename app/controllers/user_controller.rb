class UserController < ApplicationController
	#skip_before_action :verify_authenticity_token, only: [:one_or_two_actions_here]
	def index
		@users=User.all
	end

	def textForSong
		account_sid = "ACa0f1dab35e78b3d1a75d65bd7a639b58" # Your Account SID from www.twilio.com/console
		auth_token = "195fe9a65be40d1df9bf42c7256b139a"   # Your Auth Token from www.twilio.com/console
    	@client = Twilio::REST::Client.new account_sid, auth_token
    	message = @client.account.messages.create(:body => "Hello from Ruby",
        :to => "+13479825878",    # Replace with your phone number
        :from => "+16466813898")  # Replace with your Twilio number
        puts "here"
        call = @client.account.calls.create(:url => "https://momoalice.github.io/test.xml",
    	:to => "+13479825878",
    	:from => "+16466813898")
		puts call.to
	end

	def renderSongText
		@info = params[:Body]
		puts @info
	end
end
