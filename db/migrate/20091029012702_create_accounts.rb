class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.integer :manager_id
      t.timestamps
    end
    change_table :users do |t|
      t.references :account
    end
    change_table :pages do |t|
      t.references :account
    end
    change_table :albums do |t|
      t.references :account
    end
    change_table :photos do |t|
      t.references :account
    end
  end

  def self.down
    remove_column :pages, :account_id
    remove_column :albums, :account_id
    remove_column :photos, :account_id
    remove_column :users, :account_id

    drop_table :accounts
  end
end
