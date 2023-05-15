class Refeicao < ApplicationRecord
    self.table_name = 'refeicoes'

    validates :id_usuario, presence: true
    validates :tipo, presence: true
    validates :unidade_bandejao, presence: true
    validates :data, presence: true
    validates :dia_da_semana, presence: true

    attr_accessor :id_usuario, :tipo, :cardapio, :unidade_bandejao, :data, :dia_da_semana, :status_confirmacao, :status_validez
end