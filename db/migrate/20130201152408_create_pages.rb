class CreatePages < ActiveRecord::Migration
  
  def change
    create_table :pages do |t|
      t.references :subject # the same as: t.integer "subject_id"
      t.string "name"
      t.string "permalink"
      t.integer "position"
      t.boolean "visible", :defailt => false
      t.timestamps
    end
    add_index "pages", "subject_id"
    add_index "pages", "permalink"
  end
  
end
