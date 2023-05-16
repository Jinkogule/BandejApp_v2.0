# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_15_152609) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "adminpack"
  enable_extension "plpgsql"

  create_table "calendario", force: :cascade do |t|
    t.string "dia_da_semana"
    t.date "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "refeicoes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "tipo"
    t.string "unidade_bandejao"
    t.string "cardapio"
    t.string "dia_da_semana"
    t.date "data"
    t.string "status_confirmacao", limit: 1, default: "N"
    t.string "status_validez", limit: 1, default: "V"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "tipo", "data"], name: "index_refeicoes_on_user_id_and_tipo_and_data", unique: true
    t.index ["user_id"], name: "index_refeicoes_on_user_id"
  end

  create_table "sugestoes_de_melhorias", force: :cascade do |t|
    t.string "nome"
    t.string "sobrenome"
    t.bigint "user_id"
    t.string "email"
    t.string "assunto", limit: 500
    t.string "sugestao", limit: 2000
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sugestoes_de_melhorias_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nome", limit: 255
    t.string "sobrenome", limit: 255
    t.string "data_nascimento"
    t.string "email"
    t.datetime "email_verified_at"
    t.string "password", limit: 255
    t.integer "peso"
    t.string "altura"
    t.string "status"
    t.string "unidade_bandejao"
    t.string "user_type"
    t.string "remember_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "refeicoes", "users"
  add_foreign_key "refeicoes", "users", name: "fk_refeicoes_users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sugestoes_de_melhorias", "users"
end
