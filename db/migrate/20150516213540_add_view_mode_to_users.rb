class AddViewModeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :view_mode, :integer
  end
end
