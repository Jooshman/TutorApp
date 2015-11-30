class CreateUserreviews < ActiveRecord::Migration
  def change
    create_table :userreviews do |t|
      t.string :name
      t.text :body
      t.integer :userlogin_id

      t.timestamps null: false
    end
  end
end
