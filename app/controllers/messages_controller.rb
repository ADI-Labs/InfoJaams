class MessagesController < ApplicationController
 skip_before_filter :verify_authenticity_token
 #skip_before_filter :authenticate_user!, :only => "reply"



  def reply
    from_number = params["From"]

    if User.exists?(phone_number: from_number.to_s)
      puts "MADE IT HERE"
      puts "hi"
      u = User.find_by(phone_number: from_number.to_s)
      puts "Hello"
      account_sid = 'ACf4ffde17e6c54016acef9309e1c69bcc'
      auth_token = '44a85afbed6a67013e46198132f8232f'
      @client = Twilio::REST::Client.new account_sid, auth_token

      message_body = params["Body"]
      key_words= message_body.split(" ", 2);
      puts key_words
      if key_words[0] == "Search"
        BingSearch.account_key = 'HBqI/Aby4J6YoPBqgXHNTcvSoQzfXdrmDTykSeoBb0U'
        message = ""
        search_query = key_words[1]
        results = BingSearch.web(key_words[1],limit: 5)
        count = 1
        urlText = Hash.new
        results.each do |r|
            puts count
            puts r.title
            puts r.summary
            puts r.url

            urlText[count] = r.url
            message += "\n" + count.to_s + "\n" + r.summary + "\n" + r.url
            count += 1
        end
        u.update_attribute(:last_query, urlText)
        from_number = params["From"]
        sms = @client.messages.create(
          from: '+16267747914',
          to: from_number,
          body: "Hello there, thanks for texting me." + message
        )
      elsif is_number(key_words[0])
        renderText
      else
        sms = @client.messages.create(
          from: '+16267747914',
          to: from_number,
          body: "Please start your text with the appropriate commands"
        )
      end
    end
  end

  #method checks if the text message sent is an integer between
  def is_number string
    true if Integer(string) > 0 && Integer(string) <6
    rescue false
  end

  def renderText
    account_sid = 'ACf4ffde17e6c54016acef9309e1c69bcc'
    auth_token = '44a85afbed6a67013e46198132f8232f'
    @client = Twilio::REST::Client.new account_sid, auth_token
    message = ""
    from_number = params["From"]
    if User.find_by(phone_number: from_number )
      message_body = params["Body"]
      if is_number(message_body)
        descriptNum = message_body.to_i
        #puts descriptNum
        u = User.where(phone_number: from_number).select(:last_query).take
        urlHash = u.last_query
        eval(urlHash)

        url = urlHash[descriptNum]
        puts url
        #puts url
        #puts Nokogiri::HTML(url).text
        #message = Nokogiri::HTML(url).text
        message = urlHash
        sms = @client.messages.create(
          from: '+16267747914',
          to: from_number,
          body: message
        )
      else
        sms = @client.messages.create(
          from: '+16267747914',
          to: from_number,
          body: "Hello there, please send an integer between 1-5 for more results."
        )
      end
    else
      sms = @client.messages.create(
        from: '+16267747914',
        to: from_number,
        body: "Hello there, thanks for texting me. This feature is only for
        registered users."
      )
    end
  end
end
