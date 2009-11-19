class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.string :name

      t.timestamps
    end
    add_column :photos, :album_id, :integer
  end

  def self.down
    remove_column :photos, :album_id
    drop_table :albums
  end
end
