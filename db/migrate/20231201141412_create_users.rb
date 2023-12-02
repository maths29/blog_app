class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :Name
      t.string :Photo
      t.text :Bio

      t.timestamps
    end
  end
end
