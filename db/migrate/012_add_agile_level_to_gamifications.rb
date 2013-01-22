class AddAgileLevelToGamifications < ActiveRecord::Migration
  def self.up
    add_column :gamifications, :agile_level, :integer, default: 0
  end

  def self.down
    remove_column :gamifications, :agile_level
  end
end
