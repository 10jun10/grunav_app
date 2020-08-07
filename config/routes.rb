Rails.application.routes.draw do
  root 'restaurants#search'
  get 'restaurants/index'
end
