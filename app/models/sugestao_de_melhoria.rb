class SugestaoDeMelhoria < ApplicationRecord
    self.table_name = 'sugestoes_de_melhorias'
  
    attr_accessor :nome, :sobrenome, :id_usuario, :email, :assunto, :sugestao
end