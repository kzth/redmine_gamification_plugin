class AddImageToGamifications < ActiveRecord::Migration
  def self.up
    add_column :gamifications, :image, :binary
  end

  def self.down
    remove_column :gamifications, :image
  end
end
