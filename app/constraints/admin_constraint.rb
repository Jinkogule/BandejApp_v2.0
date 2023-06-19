class AdminConstraint
    def matches?(request)
        user_id = request.session[:id]
        user_type = request.session[:user_type]
        
        if user_id.present? && user_type.present? && user_type == 'Administrador'
            true
        else
            request.flash[:erro] = 'Acesso não autorizado, você não é um administrador.'
            false
        end
    end
end