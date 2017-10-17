class AddIndexToContractorsEmail < ActiveRecord::Migration[5.1]
  def change
    add_index :contractors, :email, unique: true
  end
end
