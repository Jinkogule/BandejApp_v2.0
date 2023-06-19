class Refeicao < ApplicationRecord
    self.table_name = 'refeicoes'

    validates :user_id, presence: true
    validates :tipo, presence: true
    validates :unidade_bandejao, presence: true
    validates :data, presence: true
    validates :dia_da_semana, presence: true
end