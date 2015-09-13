class RemoveZipCodeFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :ZipCode, :string
  end
end
