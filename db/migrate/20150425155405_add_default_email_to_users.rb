class AddDefaultEmailToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :email
    add_column :users, :default_email_id, :integer
  end
end