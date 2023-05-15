class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :nome
      t.string :sobrenome
      t.string :data_nascimento
      t.string :email, unique: true
      t.datetime :email_verified_at, null: true
      t.string :password
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