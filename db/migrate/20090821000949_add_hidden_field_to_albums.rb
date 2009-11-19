class AddHiddenFieldToAlbums < ActiveRecord::Migration
  def self.up
    add_column :albums, :hidden, :boolean, :default => false
  end

  def self.down
    remove_column :albums, :hidden
  end
end
