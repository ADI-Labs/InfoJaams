class UsersController < ApplicationController
  
  def new
  	# params[name, password, email, phoneNum]

  	# User.new(info from params)
  	# if User.save 
  	# => save it 
  	# else 
  	# return some error 
    @user = User.new
  end


  def show
    @user = User.find(params[:id])
  end


  def create
    @user = User.new(params[:user])    # Not the final implementation!
    if @user.save
      # Handle a successful save if everything is ok.
    else
      render 'new'
    end
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
