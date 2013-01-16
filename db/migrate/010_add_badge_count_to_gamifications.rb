class AddBadgeCountToGamifications < ActiveRecord::Migration
  def self.up
    add_column :gamifications, :badge_count, :integer, default: 0
  end

  def self.down
    remove_column :gamifications, :badge_count
  end
end
