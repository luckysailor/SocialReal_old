class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :name
      t.string :email
      t.string :picture
      t.string :location
      t.string :language
      t.string :favorite_topics
      t.string :my_articles
      t.string :my_softwares_client
      t.boolean :hidden, :default => 0

      t.timestamps
    end
    add_index :profiles, :user_id, unique: true
    add_index :profiles, :name
  end
end
