class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :email
      t.string :address
      t.decimal :balance

      t.timestamps
    end
  end
end
