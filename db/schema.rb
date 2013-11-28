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

ActiveRecord::Schema.define(:version => 20121031154501244) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "comentarios", :force => true do |t|
    t.integer  "usuario_id"
    t.integer  "receta_id"
    t.text     "comentario"
    t.integer  "status",     :default => 1
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "forem_categories", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  add_index "forem_categories", ["slug"], :name => "index_forem_categories_on_slug", :unique => true

  create_table "forem_forums", :force => true do |t|
    t.string  "title"
    t.text    "description"
    t.integer "category_id"
    t.integer "views_count", :default => 0
    t.string  "slug"
  end

  add_index "forem_forums", ["slug"], :name => "index_forem_forums_on_slug", :unique => true

  create_table "forem_groups", :force => true do |t|
    t.string "name"
  end

  add_index "forem_groups", ["name"], :name => "index_forem_groups_on_name"

  create_table "forem_memberships", :force => true do |t|
    t.integer "group_id"
    t.integer "member_id"
  end

  add_index "forem_memberships", ["group_id"], :name => "index_forem_memberships_on_group_id"

  create_table "forem_moderator_groups", :force => true do |t|
    t.integer "forum_id"
    t.integer "group_id"
  end

  add_index "forem_moderator_groups", ["forum_id"], :name => "index_forem_moderator_groups_on_forum_id"

  create_table "forem_posts", :force => true do |t|
    t.integer  "topic_id"
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "reply_to_id"
    t.string   "state",       :default => "pending_review"
    t.boolean  "notified",    :default => false
  end

  add_index "forem_posts", ["reply_to_id"], :name => "index_forem_posts_on_reply_to_id"
  add_index "forem_posts", ["state"], :name => "index_forem_posts_on_state"
  add_index "forem_posts", ["topic_id"], :name => "index_forem_posts_on_topic_id"
  add_index "forem_posts", ["user_id"], :name => "index_forem_posts_on_user_id"

  create_table "forem_subscriptions", :force => true do |t|
    t.integer "subscriber_id"
    t.integer "topic_id"
  end

  create_table "forem_topics", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "subject"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.boolean  "locked",       :default => false,            :null => false
    t.boolean  "pinned",       :default => false
    t.boolean  "hidden",       :default => false
    t.datetime "last_post_at"
    t.string   "state",        :default => "pending_review"
    t.integer  "views_count",  :default => 0
    t.string   "slug"
  end

  add_index "forem_topics", ["forum_id"], :name => "index_forem_topics_on_forum_id"
  add_index "forem_topics", ["slug"], :name => "index_forem_topics_on_slug", :unique => true
  add_index "forem_topics", ["state"], :name => "index_forem_topics_on_state"
  add_index "forem_topics", ["user_id"], :name => "index_forem_topics_on_user_id"

  create_table "forem_views", :force => true do |t|
    t.integer  "user_id"
    t.integer  "viewable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count",             :default => 0
    t.string   "viewable_type"
    t.datetime "current_viewed_at"
    t.datetime "past_viewed_at"
  end

  add_index "forem_views", ["updated_at"], :name => "index_forem_views_on_updated_at"
  add_index "forem_views", ["user_id"], :name => "index_forem_views_on_user_id"
  add_index "forem_views", ["viewable_id"], :name => "index_forem_views_on_topic_id"

  create_table "grupos", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "grupos", ["slug"], :name => "index_grupos_on_slug", :unique => true

  create_table "grupos_recipes", :id => false, :force => true do |t|
    t.integer "recipe_id"
    t.integer "grupo_id"
  end

  add_index "grupos_recipes", ["grupo_id", "recipe_id"], :name => "index_grupos_receta_on_grupo_id_and_receta_id"
  add_index "grupos_recipes", ["recipe_id", "grupo_id"], :name => "index_grupos_receta_on_receta_id_and_grupo_id"

  create_table "legacy_users", :primary_key => "c_personid", :force => true do |t|
    t.string   "email",              :limit => 128, :default => "",  :null => false
    t.string   "password",           :limit => 512, :default => "",  :null => false
    t.string   "fname",              :limit => 32,  :default => "",  :null => false
    t.string   "lname",              :limit => 32,  :default => "",  :null => false
    t.date     "birthdate"
    t.string   "optin_recetas",      :limit => 1,   :default => "",  :null => false
    t.string   "address",            :limit => 512
    t.string   "postalcode",         :limit => 10
    t.string   "city",               :limit => 32,  :default => ""
    t.string   "country",            :limit => 32,  :default => ""
    t.string   "state",              :limit => 32,  :default => ""
    t.string   "mobile",             :limit => 10,  :default => ""
    t.string   "phone",              :limit => 10,  :default => ""
    t.string   "gender",             :limit => 1,   :default => ""
    t.string   "active",             :limit => 1,   :default => "1", :null => false
    t.datetime "creationdate",                                       :null => false
    t.datetime "lastlogindate",                                      :null => false
    t.string   "fuid",               :limit => 128
    t.string   "optin_ofertas",      :limit => 1
    t.string   "optin_recompensas",  :limit => 1,                    :null => false
    t.integer  "kids_number"
    t.string   "salt",               :limit => 10,                   :null => false
    t.string   "optin2_recompensas", :limit => 1,   :default => "0"
  end

  add_index "legacy_users", ["creationdate"], :name => "x_user_data_02"
  add_index "legacy_users", ["email"], :name => "x_user_data_01"
  add_index "legacy_users", ["lastlogindate"], :name => "x_user_data_03"
  add_index "legacy_users", ["state"], :name => "x_user_data_04"

  create_table "medios", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "titulo"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "products", ["slug"], :name => "index_products_on_slug", :unique => true

  create_table "rates", :force => true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "stars",         :null => false
    t.string   "dimension"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "rates", ["rateable_id", "rateable_type"], :name => "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rater_id"], :name => "index_rates_on_rater_id"

  create_table "rating_caches", :force => true do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            :null => false
    t.integer  "qty",            :null => false
    t.string   "dimension"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], :name => "index_rating_caches_on_cacheable_id_and_cacheable_type"

  create_table "receta_medios", :id => false, :force => true do |t|
    t.integer "receta_id"
    t.integer "medio_id"
  end

  add_index "receta_medios", ["medio_id", "receta_id"], :name => "index_receta_medios_on_medio_id_and_receta_id"
  add_index "receta_medios", ["receta_id", "medio_id"], :name => "index_receta_medios_on_receta_id_and_medio_id"

  create_table "receta_usos", :id => false, :force => true do |t|
    t.integer "receta_id"
    t.integer "uso_id"
  end

  add_index "receta_usos", ["receta_id", "uso_id"], :name => "index_receta_usos_on_receta_id_and_uso_id"
  add_index "receta_usos", ["uso_id", "receta_id"], :name => "index_receta_usos_on_uso_id_and_receta_id"

  create_table "recetas", :force => true do |t|
    t.string   "titulo"
    t.string   "categoria"
    t.boolean  "receta_dia"
    t.boolean  "receta_facil"
    t.boolean  "receta_especial"
    t.boolean  "receta_temporada"
    t.boolean  "saludable"
    t.boolean  "receta_postre"
    t.string   "imagen"
    t.integer  "tiempo"
    t.text     "ingredientes"
    t.text     "preparacion"
    t.text     "tips"
    t.string   "puntuacion"
    t.boolean  "video"
    t.string   "tipo_platillo"
    t.boolean  "p_entrada"
    t.boolean  "p_botana"
    t.boolean  "p_ensalada"
    t.boolean  "p_guarnicion"
    t.boolean  "p_sopa"
    t.boolean  "p_platofuerte"
    t.boolean  "p_aves"
    t.boolean  "p_carne"
    t.boolean  "p_pasta"
    t.boolean  "p_pescado"
    t.boolean  "p_otros"
    t.boolean  "p_light"
    t.boolean  "p_postre"
    t.integer  "product_id"
    t.boolean  "featured"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "migrado"
    t.boolean  "desayuno"
    t.boolean  "p_cerdo"
    t.boolean  "aprobado"
    t.boolean  "t_relleno"
    t.boolean  "t_salsa"
    t.boolean  "t_licuadora"
    t.boolean  "t_sarten"
    t.integer  "porciones"
    t.integer  "dificultad"
    t.boolean  "t_mezclar"
    t.boolean  "t_hornear"
    t.string   "slug"
    t.string   "recipe_photo"
    t.boolean  "t_batir",                :default => false
    t.boolean  "t_ensalada",             :default => false
    t.text     "etiquetas"
    t.string   "pic_big_file_name"
    t.string   "pic_big_content_type"
    t.integer  "pic_big_file_size"
    t.datetime "pic_big_updated_at"
    t.string   "pic_small_file_name"
    t.string   "pic_small_content_type"
    t.integer  "pic_small_file_size"
    t.datetime "pic_small_updated_at"
    t.integer  "orden"
    t.string   "video_url"
    t.string   "comunidad_autor"
  end

  add_index "recetas", ["orden"], :name => "index_recetas_on_orden"
  add_index "recetas", ["pic_big_file_name"], :name => "index_recetas_on_pic_big_file_name"
  add_index "recetas", ["recipe_photo"], :name => "index_recetas_on_recipe_photo"
  add_index "recetas", ["slug"], :name => "index_recetas_on_slug", :unique => true

  create_table "recipes_utensilios", :id => false, :force => true do |t|
    t.integer "recipe_id"
    t.integer "utensilio_id"
  end

  add_index "recipes_utensilios", ["recipe_id", "utensilio_id"], :name => "index_receta_utensilios_on_receta_id_and_utensilio_id"
  add_index "recipes_utensilios", ["utensilio_id", "recipe_id"], :name => "index_receta_utensilios_on_utensilio_id_and_receta_id"

  create_table "usos", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.string   "rol",                                   :default => "usuario"
    t.text     "meta"
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.string   "email",                                 :default => "",               :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",               :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean  "forem_auto_subscribe",                  :default => false
    t.string   "forem_state",                           :default => "pending_review"
    t.boolean  "forem_admin",                           :default => false
    t.string   "provider"
    t.string   "uid"
    t.string   "pic"
  end

  add_index "usuarios", ["confirmation_token"], :name => "index_usuarios_on_confirmation_token", :unique => true
  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["provider"], :name => "index_usuarios_on_provider"
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true
  add_index "usuarios", ["uid"], :name => "index_usuarios_on_uid"

  create_table "utensilios", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "utensilios", ["slug"], :name => "index_utensilios_on_slug", :unique => true

end
