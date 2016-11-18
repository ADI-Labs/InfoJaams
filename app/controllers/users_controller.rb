class UsersController < ApplicationController
  
  def new
  	# params[name, password, email, phoneNum]

  	# User.new(info from params)
  	# if User.save 
  	# => save it 
  	# else 
  	# return some error 

  end


  # def search 
  # 	@currentUser = User.find_by(:name => params[name])

  # 	# search = Search.search(params["text"])

  #  	User.update_attribute(:search => search)

  #  	User.save

  # end


  # def getHealth 
  	
  # 	@currentUser = User.find_by(:name => params[name])


  # 	data = @currentUser.healthNews


  # 	for each datapoint in data :

  # 		chartkick.graph(datapoint)




  # end


end
