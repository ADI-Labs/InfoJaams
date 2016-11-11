Rails.application.routes.draw do
  root 'welcome#index'


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
