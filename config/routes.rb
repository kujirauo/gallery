Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: "home#index"
  resources :users
  get "users/:id/likes" => "users#likes"
  resources :pictures
  post "likes/:picture_id/create" => "likes#create"
  post "likes/:picture_id/destroy" => "likes#destroy"
  delete 'pictures/:id' => 'pictures#destroy'
end
