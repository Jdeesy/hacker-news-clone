class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.string :title, null: false
      t.text :body, null: false

      t.timestamps null: false
    end
  end
end
