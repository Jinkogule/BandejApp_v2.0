class UserController < ApplicationController
    def dashboard
        q_refeicoes = Refeicao.where(user_id: session[:id]).count
      
        # Vai para o Planejamentomensal caso não possua refeições registradas
        if q_refeicoes.zero?
            redirect_to user_planejamento_mensal_path
        else
            hoje = Date.today
      
          
            events = Refeicao.where(user_id: session[:id]).order(:data, :tipo).paginate(page: 1, per_page: 20)
            events2 = Refeicao.where(user_id: session[:id]).order(data: :desc, tipo: :desc).paginate(page: 1, per_page: 20)
            verif_null = Refeicao.exists?(user_id: session[:id])
      
            render 'user/dashboard', events: events, events2: events2, verif_null: verif_null
        end
    end

    def planejamento_mensal
        unidade_bandejao = session[:unidade_bandejao]
        user_id = session[:id]

        @calendario_dias = Calendario.where.not(data: nil).where.not(dia_da_semana: ['Sábado', 'Domingo']).order(:data).paginate(page: params[:page], per_page: 10)
        render 'user/planejamento-mensal', locals: { unidade_bandejao: unidade_bandejao, user_id: user_id}
    end
      
    def selecionar_todas_refeicoes
        calendario = Calendario.all.paginate(page: params[:page], per_page: 10)
      
        calendario.each do |event|
            unless Refeicao.exists?(user_id: session[:id], tipo: 'Almoço', data: event.data.to_date)
                Refeicao.create(
                    user_id: session[:id],
                    tipo: 'Almoço',
                    unidade_bandejao: session[:unidade_bandejao],
                    data: event.data.to_date,
                    dia_da_semana: event.dia_da_semana
                )
            end
        end
      
        calendario.each do |event|
            unless Refeicao.exists?(user_id: session[:id], tipo: 'Janta', data: event.data.to_date)
                Refeicao.create(
                    user_id: session[:id],
                    tipo: 'Janta',
                    unidade_bandejao: session[:unidade_bandejao],
                    data: event.data.to_date,
                    dia_da_semana: event.dia_da_semana
                )
            end
        end
      
        redirect_to user_planejamento_mensal_path, notice: 'Refeições registradas com sucesso!'
      end
      
      
      def desselecionar_todas_refeicoes
        Refeicao.where(user_id: session[:id]).where.not(status_confirmacao: 'C').destroy_all
      
        redirect_to user_planejamento_mensal_path, notice: 'Refeições removidas com sucesso!'
      end
      
      
end
