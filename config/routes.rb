Rails.application.routes.draw do
  resources :artists, only: [:index, :show] do 
    resources :songs, only: [:show, :index]
  end

  resources :songs
end
