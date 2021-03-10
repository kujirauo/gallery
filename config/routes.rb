Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: "home#index"
  resources :users
  get "users/:id/likes" => "users#likes"
  resources :pictures do
    resources :likes #, only: [:create, :destroy]
  end

  post "likes/:picture_id/create" => "likes#create"
  post "likes/:picture_id/destroy" => "likes#destroy"
  #post "pictures/:id/destroy" => "pictures#destroy"
  post "/pictures/:picture_id/destroy" => "pictures#destroy"
  #get 'search' => 'pictures#search'
end

