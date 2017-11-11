class AddCompletionToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :account_completed, :boolean, default: false
  end
end
