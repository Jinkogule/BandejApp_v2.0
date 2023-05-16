Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get '/', to: 'auth#index', as: 'login'
  get '/cadastro', to: 'auth#view_cadastro', as: 'cadastro'

  post 'realizar_cadastro', to: 'auth#realizar_cadastro', as: 'realizar_cadastro'
  post 'realizar_login', to: 'auth#realizar_login', as: 'realizar_login'

  get '/dashboard', to: 'user#dashboard', as: 'user_dashboard'

end
