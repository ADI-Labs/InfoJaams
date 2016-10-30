class UserController < ApplicationController
	#skip_before_action :verify_authenticity_token, only: [:one_or_two_actions_here]
	def index
		@users=User.all
	end

	#ngrok path for tomcat server of the day
	Server_Path = "http://3b4a4234.ngrok.io"
	File_Path='/usr/local/apache-tomcat-8.5.6/webapps/test/'

	def renderAndReply

	end

	def textForSong
		@songName = params[:Body]
		@userPhone= params[:From]
		#puts @userPhone
		account_sid = "ACa0f1dab35e78b3d1a75d65bd7a639b58" # Your Account SID from www.twilio.com/console
		auth_token = "195fe9a65be40d1df9bf42c7256b139a"   # Your Auth Token from www.twilio.com/console
		@client = Twilio::REST::Client.new account_sid, auth_token
		message = @client.account.messages.create(:body => "The song you are asking for is "+@songName,
        :to => @userPhone,    # Replace with your phone number
        :from => "+16466813898")  # Replace with your Twilio number
        
		#search for song
        get_youtube_service
		@videoID = searchSong @songName
		#convert and save mp3
		youtube_in_mp3 @songName,@videoID
		@songName = @songName.gsub(" ","_")
		
		writeXml(@songName)

		call = @client.account.calls.create(:url => Server_Path + "/test/#{@songName}.xml",
			:to => @userPhone,
			:from => "+16466813898")
		puts call.to
		puts "call end"
	end

	def textForRoute

	end

	# !/usr/bin/ruby

	def testRoute
		origin = "350, 5th Ave, NY"
		destination = [40.777552, -73.954732]
		options = {:language => 'pt'}
		GoogleMapsAPI::Directions.route(origin, destination, options)
	end

	def get_map_service
		gmaps = GoogleMapsService::Client.new(key: DEVELOPER_KEY)
	end


	
	def writeXml(songName)
		@path=File_Path + songName + ".xml"
		dir = File.dirname(File_Path + songName)
		unless File.directory?(dir)
    		FileUtils.mkdir_p(dir)
  		end
  		writtenFile = File.new(@path, 'w')
  		writtenFile.syswrite("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n")
  		writtenFile.syswrite("<Response>\n")
  		writtenFile.syswrite("<Play>" + Server_Path + "/test/#{songName}.mp3</Play>\n")
  		writtenFile.syswrite("</Response>")
	end





	def youtube_in_mp3(title, id)
		puts "The video's id is " + id

    	mp3 = open("http://www.youtubeinmp3.com/fetch/?video=http://www.youtube.com/watch?v=#{id}")
    	title=title.gsub(" ","_")
		FileUtils.mv(mp3.path, File.expand_path(File_Path + "/#{title}.mp3"))
    end



	# Set DEVELOPER_KEY to the API key value from the APIs & auth > Credentials
	# tab of
	# Google Developers Console <https://console.developers.google.com/>
	# Please ensure that you have enabled the YouTube Data API for your project.
	DEVELOPER_KEY = 'AIzaSyCNI7LxiiF6VgRn5iyLTaWaTitKoI1dmWY'

	def get_youtube_service
		@youtube = Google::Apis::YoutubeV3::YouTubeService.new
		@youtube.key=DEVELOPER_KEY
	end
	def searchSong(term)
		puts "The thing I am searching for" + term
		#puts @youtube.list_searches('snippet', q: term, max_results: num).items
		@firstResul = sanitize @youtube.list_searches('snippet', q: term, max_results: 1).items
		@firstId= @firstResul[:id]
		return @firstId
	end

  	# reject bad results and store in a more useful format.
	def sanitize(raw_results)
		raw_results.reject do |result|
			result.kind != "youtube#video"
		end
		list = raw_results.map do |result|
			{ title: result.snippet.title,
				image: result.snippet.thumbnails.high.url,
				id:    result.id.video_id }
			end
		# only return top result (for queue).
		list.first
	end


end
