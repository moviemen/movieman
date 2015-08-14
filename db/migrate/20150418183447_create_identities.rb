class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.references :user, index: true, foreign_key: true
      t.string :provider
      t.string :uid
      t.string :oauth_token
      t.string :oauth_expires_at

      t.timestamps null: false
    end
  end
end
