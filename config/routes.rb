Rails.application.routes.draw do
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  resources :contacts
  get 'contact-us', to: 'contacts#new' #This is to make a custom URL, routing to the new method of the contacts controller
end
