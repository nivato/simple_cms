class CreateUsers < ActiveRecord::Migration
  
  def change
    create_table :users do |t|
      #t.integer "id" # is automatically created
      t.string "first_name", :limit => 25
      t.string "last_name", :limit => 50
      t.string "email", :default => "", :null => false
      t.string "password", :limit => 40
      #t.datetime "created_at" # t.timestamps does this for you
      #t.datetime "updated_at" # t.timestamps does this for you
      t.timestamps
    end
  end
  
end
