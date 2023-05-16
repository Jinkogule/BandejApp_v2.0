class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :nome, limit: 255
      t.string :sobrenome, limit: 255
      t.string :data_nascimento
      t.string :email, unique: true
      t.datetime :email_verified_at, null: true
      t.string :password, limit: 255
      t.integer :peso
      t.string :altura
      t.string :status
      t.string :unidade_bandejao
      t.string :user_type, null: true
      t.string :remember_token
      t.timestamps
    end
  end
end