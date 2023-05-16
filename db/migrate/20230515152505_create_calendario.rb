class CreateCalendario < ActiveRecord::Migration[7.0]
  def change
    create_table :calendario do |t|
      t.string :dia_da_semana
      t.date :data

      t.timestamps
    end
  end
end