Rails.application.routes.draw do
  root "pages#home"
  get "about", to: "pages#about"
  #resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy, :delete] #only shows route 'show'
  resources :articles
end
