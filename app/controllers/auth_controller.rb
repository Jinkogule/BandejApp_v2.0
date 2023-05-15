class AuthController < ApplicationController

    def index
        render 'auth/login'
    end

    def realizar_login
        email = params[:email]
        password = params[:password]
      
        if email.present? && password.present?
            user = User.find_by(email: email)
          
            if user && user.authenticate(password)
                session[:nome] = user.nome
                session[:id] = user.id
                session[:user_type] = user.user_type
                session[:user_email] = user.email
      
            if user.user_type == 'Administrator'
                redirect_to admin_dashboard_path
            else
                session[:unidade_bandejao] = user.unidade_bandejao
                redirect_to user_dashboard_path
            end
        else
            redirect_to login_path, flash: { erro: 'Dados inseridos são inválidos.' }
        end
        else
          redirect_to login_path, flash: { erro: 'Email e senha são obrigatórios.' }
        end
    end

    def view_cadastro
        render 'auth/cadastro'
    end
end
