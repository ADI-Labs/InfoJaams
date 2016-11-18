Rails.application.routes.draw do
  root 'welcome#index'
  #post "/user/userTextSong" => 'user#renderSongText'
  post "user/textMessageIn" => 'user#renderAndProcess'
  get "user/testGoogle" => "user#testRoute"
  #post "user/textForSong" 
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


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
