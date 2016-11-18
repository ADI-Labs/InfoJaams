Rails.application.routes.draw do
  #post "/user/userTextSong" => 'user#renderSongText'
  post "user/textMessageIn" => 'user#renderAndProcess'
  get "user/testGoogle" => "user#testRoute"
  #post "user/textForSong" 
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#index'

   get '/general', to: 'welcome#general'
   get '/news', to: 'welcome#news'
   get '/music', to: 'welcome#music'
   get '/health', to: 'welcome#health'
   
  get '/login', to: 'welcome#login'
  #get '/home', to: 'welcome#index'
  get '/about', to: 'welcome#about'
  get '/signup',  to: 'users#new' 
  get '/password', to: 'users#password'

  get 'welcome/index'
  post 'welcome/index' => 'welcome#index'
  post 'messages/reply' => 'messages#reply'
  get 'bing' => 'bing#getResults'

  resource :messages do
    collection do
      post 'reply'
    end
  end
end
