Rails.application.routes.draw do
  root 'restaurants#search'
  get 'restaurants/index'
  get 'restaurants/:id' => 'restaurants#show'
end
