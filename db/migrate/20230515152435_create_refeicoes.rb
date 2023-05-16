class CreateRefeicoes < ActiveRecord::Migration[7.0]
  def change
    create_table :refeicoes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :tipo
      t.string :unidade_bandejao
      t.string :cardapio
      t.string :dia_da_semana
      t.date :data
      t.string :status_confirmacao, limit: 1, default: 'N'
      t.string :status_validez, limit: 1, default: 'V'
      t.timestamps

      t.index [:user_id, :tipo, :data], unique: true

      t.foreign_key :users, column: :user_id, name: 'fk_refeicoes_users', on_delete: :cascade, on_update: :cascade
    end
  end
end