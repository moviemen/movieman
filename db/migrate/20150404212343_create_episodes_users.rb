class CreateEpisodesUsers < ActiveRecord::Migration
  def self.up
    create_table :episodes_users do |t|
      t.integer :episode_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :episodes_users, [:episode_id, :user_id]
    add_index :episodes_users, :user_id
  end

  def self.down
    drop_table :episodes_users
  end
end
