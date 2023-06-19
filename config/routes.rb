require_relative '../app/constraints/admin_constraint'
require_relative '../app/constraints/user_constraint'


Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get '/', to: 'auth#index', as: 'login'
  get '/cadastro', to: 'auth#view_cadastro', as: 'cadastro'

  post 'realizar_cadastro', to: 'auth#realizar_cadastro', as: 'realizar_cadastro'
  post 'realizar_login', to: 'auth#realizar_login', as: 'realizar_login'

  get 'sair', to: 'auth#sair', as: 'sair'


  get '/dashboard', to: 'user#dashboard', as: 'user_dashboard', constraints: UserConstraint.new
  get '/planejamento_mensal', to: 'user#planejamento_mensal', as: 'user_planejamento_mensal', constraints: UserConstraint.new

  post '/selecionar_todas_refeicoes', to: 'user#selecionar_todas_refeicoes', as: 'selecionar_todas_refeicoes'
  post '/desselecionar_todas_refeicoes', to: 'user#desselecionar_todas_refeicoes', as: 'desselecionar_todas_refeicoes'

end
