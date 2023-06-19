class Calendario < ApplicationRecord
    self.table_name = 'calendario'

    validates :dia_da_semana, presence: true
    validates :data, presence: true
end