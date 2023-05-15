class CreateSugestoesDeMelhorias < ActiveRecord::Migration[6.1]
  def change
    create_table :sugestao_de_melhorias do |t|
      t.string :nome
      t.string :sobrenome
      t.belongs_to :usuario, foreign_key: true
      t.string :email
      t.string :assunto, limit: 500
      t.string :sugestao, limit: 2000

      t.timestamps
    end
  end
end