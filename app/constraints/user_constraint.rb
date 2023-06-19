class UserConstraint
    def matches?(request)
        user_id = request.session[:id]
        user_type = request.session[:user_type]

        if user_id.present? && user_type.present? && user_type == 'Usuario'
            true
        else
            request.flash[:erro] = 'Acesso não autorizado, você não é um usuário.'
            false
        end
    end
end

  
  
  
  