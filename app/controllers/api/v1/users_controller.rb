class Api::V1::UsersController < ApplicationController
    def dashboard
        q_refeicoes = Refeicao.where(user_id: params[:user_id]).count
    
        #Vai para o Planejamentomensal caso não possua refeições registradas
        if q_refeicoes.zero?
            render json: { message: "Nenhuma refeição registrada" }, status: :not_found
        else
            hoje = Date.today
    
            @events = Refeicao.where(user_id: params[:user_id]).order(:data, :tipo).paginate(page: 1, per_page: 20)
            @events2 = Refeicao.where(user_id: params[:user_id]).order(data: :desc, tipo: :desc).paginate(page: 1, per_page: 20)
            @verif_null = Refeicao.exists?(user_id: params[:user_id])
    
            render json: { events: @events, events2: @events2, verif_null: @verif_null }
        end
    end
  
    def planejamento_mensal
        unidade_bandejao = params[:unidade_bandejao]
        user_id = params[:user_id]
    
        @possui_refeicao_registrada = Refeicao.exists?(user_id: params[:user_id])
        @calendario_dias = Calendario.all
        @user_id = params[:user_id]
    
        render json: { possui_refeicao_registrada: @possui_refeicao_registrada, calendario_dias: @calendario_dias, user_id: @user_id }
    end
  
    def selecionar_todas_refeicoes
        calendario = Calendario.all.paginate(page: params[:page], per_page: 10)
    
        calendario.each do |event|
            unless Refeicao.exists?(user_id: params[:user_id], tipo: 'Almoço', data: event.data.to_date)
            Refeicao.create(
                user_id: params[:user_id],
                tipo: 'Almoço',
                unidade_bandejao: params[:unidade_bandejao],
                data: event.data.to_date,
                dia_da_semana: event.dia_da_semana
            )
            end
        end
    
        calendario.each do |event|
            unless Refeicao.exists?(user_id:params[:user_id], tipo: 'Janta', data:event.data.to_date)
            Refeicao.create(
                user_id:params[:user_id],
                tipo: 'Janta',
                unidade_bandejao:params[:unidade_bandejao],
                data:event.data.to_date,
                dia_da_semana:event.dia_da_semana
            )
            end
        end
    
        render json:{ message:'Refeições registradas com sucesso!' }
    end
  
    def desselecionar_todas_refeicoes
        Refeicao.where(user_id:params[:user_id]).where.not(status_confirmacao:'C').destroy_all
    
        render json:{ message:'Refeições removidas com sucesso!' }
    end
  
    def cancelar_refeicao_planejamento_almoco
        data = params.permit(:user_id, :tipo, :unidade_bandejao, :dia_da_semana, :data)
    
        
        unless data[:user_id].present? && data[:tipo].present? && data[:unidade_bandejao].present? && data[:dia_da_semana].present?
            render json:{ message:'Parâmetros inválidos' }, status::bad_request
            return
        end
    
        Refeicao.where(user_id:data[:user_id], tipo:'Almoço', data:data[:data]).delete_all
    
        render json:{ message:'Refeição cancelada com sucesso!' }
    end
  
    def cancelar_refeicao_planejamento_janta
        data = params.permit(:user_id, :tipo, :unidade_bandejao, :dia_da_semana, :data)
    
        unless data[:user_id].present? && data[:tipo].present? && data[:unidade_bandejao].present? && data[:dia_da_semana].present?
            render json:{ message:'Parâmetros inválidos' }, status::bad_request
            return
        end
    
        Refeicao.where(user_id:data[:user_id], tipo:'Janta', data:data[:data]).delete_all
    
        render json:{ message:'Refeição cancelada com sucesso!' }
    end

    def registrar_refeicao
        refeicao_params = params.permit(:user_id, :tipo, :unidade_bandejao, :dia_da_semana, :data)

        refeicao = Refeicao.create(refeicao_params)

        if refeicao.save
        render json: { message: 'Refeição registrada com sucesso!' }
        else
        render json: { message: 'Falha ao registrar refeição.' }, status: :bad_request
        end
    end

    def confirmar_refeicao
        data = params

        params.require(:id_refeicao)
        params.require(:unidade_bandejao)

        Refeicao.where(id: data[:id_refeicao]).update(status_confirmacao: 'C', unidade_bandejao: data[:unidade_bandejao])

        render json: { message: 'Refeição confirmada com sucesso!' }
    end

    def cancelar_refeicao
        id_refeicao = params[:id_refeicao]

        Refeicao.delete(id_refeicao)

        render json: { message: 'Refeição cancelada com sucesso!' }
    end
end
  