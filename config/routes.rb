Rails.application.routes.draw do
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  resources :contacts, only: :create #If limiting more than one, enter them in an array ie: [:new, :create, :etc]
  get 'contact-us', to: 'contacts#new', as: 'new_contact' #This is to make a custom URL, routing to the 'new' method of the contacts controller
end
