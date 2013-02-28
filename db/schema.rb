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

ActiveRecord::Schema.define(:version => 20130215033942) do

  create_table "bits", :force => true do |t|
    t.text     "content"
    t.string   "color"
    t.string   "type"
    t.integer  "location_x"
    t.integer  "location_y"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "clusters", :force => true do |t|
    t.integer  "location_x"
    t.integer  "location_y"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "map_id"
  end

  create_table "maps", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  create_table "parallels", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "bit_id"
    t.integer  "cluster_id"
  end

end
