require_relative '../app/constraints/admin_constraint'
require_relative '../app/constraints/user_constraint'


Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/', to: 'auth#index', as: 'login'
  get '/cadastro', to: 'auth#view_cadastro', as: 'cadastro'
  
  post 'realizar_cadastro', to: 'auth#realizar_cadastro', as: 'realizar_cadastro'
  post 'realizar_login', to: 'auth#realizar_login', as: 'realizar_login'
  
  get 'sair', to: 'auth#sair', as: 'sair'
  
  get '/user/dashboard', to: 'users#dashboard', as: 'user_dashboard', constraints: UserConstraint.new
  get '/user/planejamento_mensal', to: 'users#planejamento_mensal', as: 'user_planejamento_mensal', constraints: UserConstraint.new
  
  post '/selecionar_todas_refeicoes', to: 'users#selecionar_todas_refeicoes', as: 'selecionar_todas_refeicoes'
  post '/desselecionar_todas_refeicoes', to: 'users#desselecionar_todas_refeicoes', as: 'desselecionar_todas_refeicoes'
  
  post '/cancelar_refeicao_planejamento_almoco', to: 'users#cancelar_refeicao_planejamento_almoco', as: 'cancelar_refeicao_planejamento_almoco'
  post '/cancelar_refeicao_planejamento_janta', to: 'users#cancelar_refeicao_planejamento_janta', as: 'cancelar_refeicao_planejamento_janta'
  
  post '/registrar_refeicao', to: 'users#registrar_refeicao', as: 'registrar_refeicao'

  post '/cancelar-refeicao', to: 'users#cancelar_refeicao', as: 'cancelar_refeicao'
  post '/confirmar-refeicao', to: 'users#confirmar_refeicao', as: 'confirmar_refeicao'
  
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        collection do
          get :dashboard
          get :planejamento_mensal
          post :selecionar_todas_refeicoes
          delete :desselecionar_todas_refeicoes
          delete :cancelar_refeicao_planejamento_almoco
          delete :cancelar_refeicao_planejamento_janta
          post :registrar_refeicao
          patch :confirmar_refeicao
          delete :cancelar_refeicao
        end
      end
    end
  end
end
