class User < ApplicationRecord
    self.table_name = 'users'

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :nome, presence: true
    validates :sobrenome, presence: true
    validates :user_type, presence: true
    validates :data_nascimento, presence: true
    validates :peso, presence: true
    validates :altura, presence: true
    validates :status, presence: true
    validates :unidade_bandejao, presence: true
end