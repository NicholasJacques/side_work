class UpdateContractorTable < ActiveRecord::Migration[5.1]
  def change
    remove_column :contractors, :email
    remove_column :contractors, :password_digest
  end
end
