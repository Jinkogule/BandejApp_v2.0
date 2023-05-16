class CreateSugestoesDeMelhorias < ActiveRecord::Migration[7.0]
  def change
    create_table :sugestoes_de_melhorias do |t|
      t.string :nome
      t.string :sobrenome
      t.belongs_to :user, foreign_key: true
      t.string :email
      t.string :assunto, limit: 500
      t.string :sugestao, limit: 2000

      t.timestamps
    end
  end
end