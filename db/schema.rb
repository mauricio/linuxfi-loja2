# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111109005117) do

  create_table "categorias", :force => true do |t|
    t.string "nome",      :null => false
    t.text   "descricao"
  end

  add_index "categorias", ["nome"], :name => "index_categorias_on_nome", :unique => true

  create_table "itens", :force => true do |t|
    t.integer "pedido_id",  :null => false
    t.integer "produto_id", :null => false
    t.integer "quantidade"
  end

  add_index "itens", ["pedido_id"], :name => "index_itens_on_pedido_id"

  create_table "pedidos", :force => true do |t|
    t.string   "estado",     :default => "carrinho", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_id"
  end

  add_index "pedidos", ["usuario_id"], :name => "index_pedidos_on_usuario_id"

  create_table "produtos", :force => true do |t|
    t.string   "nome",                                        :null => false
    t.text     "descricao"
    t.decimal  "preco",        :precision => 10, :scale => 2, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "categoria_id"
  end

  add_index "produtos", ["categoria_id"], :name => "index_produtos_on_categoria_id"

  create_table "usuarios", :force => true do |t|
    t.string   "email",                               :null => false
    t.boolean  "administrador",    :default => false, :null => false
    t.string   "nome",                                :null => false
    t.string   "salt",                                :null => false
    t.string   "senha_em_hash",                       :null => false
    t.datetime "ultimo_acesso_em"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["ultimo_acesso_em"], :name => "index_usuarios_on_ultimo_acesso_em"

end
