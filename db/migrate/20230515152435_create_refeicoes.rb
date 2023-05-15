class CreateRefeicaos < ActiveRecord::Migration[6.1]
  def change
    create_table :refeicaos do |t|
      t.belongs_to :usuario, foreign_key: true
      t.string :tipo
      t.string :unidade_bandejao
      t.string :cardapio, null: true
      t.string :dia_da_semana
      t.date :data
      t.string :status_confirmacao, limit: 1, default: 'N'
      t.string :status_validez, limit: 1, default: 'V'

      t.timestamps
    end

    add_index :refeicaos, [:usuario_id, :tipo, :data], unique: true
    add_foreign_key :refeicaos, :usuarios, column: :usuario_id, on_delete: :cascade, on_update: :cascade
  end
end