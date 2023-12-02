class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :Title
      t.text :Text
      t.integer :Comments_counter
      t.integer :Likes_counter

      t.timestamps
    end
  end
end
