class AuthController < ApplicationController

    def index
        render 'auth/login'
    end

    def view_cadastro
        render 'auth/cadastro'
    end

    def realizar_cadastro
        cadastro_params = params.permit(:nome, :sobrenome, :data_nascimento, :email, :password, :peso, :altura, :status, :unidade_bandejao)
        
        if validar_cadastro(cadastro_params)
            criar_usuario(cadastro_params)
            redirect_to login_path, flash: { sucesso: 'Cadastro realizado com sucesso!' }
        else
            flash.now[:erro] = 'Erro no cadastro'
            redirect_to cadastro_path
        end
    end
    
    def validar_cadastro(params)
        return false if params[:nome].blank?
        return false if params[:sobrenome].blank?
        return false if params[:data_nascimento].blank?
        return false if params[:email].blank?
        return false if params[:password].blank?
        return false if params[:peso].blank?
        return false if params[:altura].blank?
        return false if params[:status].blank?
        return false if params[:unidade_bandejao].blank?
      
        true
    end
    
    def criar_usuario(data)
        user = User.new(
            nome: data[:nome],
            sobrenome: data[:sobrenome],
            data_nascimento: data[:data_nascimento],
            email: data[:email],
            password: BCrypt::Password.create(data[:password]),
            peso: data[:peso],
            altura: data[:altura],
            status: data[:status],
            unidade_bandejao: data[:unidade_bandejao],
            user_type: "Usuario"
        )
        
        user.save!
        
        user
    end

    def realizar_login
        if flash[:erro].present?
            @erro = flash[:erro]
          end
        email = params[:email]
        password = params[:password]
      
        if email.present? && password.present?
            user = User.find_by(email: email)
        
            if user && BCrypt::Password.new(user.password) == password
                session[:nome] = user.nome
                session[:id] = user.id
                session[:user_type] = user.user_type
                session[:user_email] = user.email
        
                if user.user_type == 'Administrador'
                    redirect_to admin_dashboard_path
                else
                    session[:unidade_bandejao] = user.unidade_bandejao
                    
                    redirect_to controller: 'user', action: 'dashboard'

                end
            else
                redirect_to login_path, flash: { erro: 'Dados inseridos são inválidos.' }
            end
        else
            redirect_to login_path, flash: { erro: 'Email e senha são obrigatórios.' }
        end
    end

    #Sair
    def sair
        reset_session
        redirect_to login_path, notice: 'Você saiu com sucesso!'
    end
end
