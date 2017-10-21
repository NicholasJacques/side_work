class ChangeUserProfileableToProfile < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :profileable_type
    remove_column :users, :profileable_id
    add_reference :users, :profile, polymorphic: true, index: true
  end
end
