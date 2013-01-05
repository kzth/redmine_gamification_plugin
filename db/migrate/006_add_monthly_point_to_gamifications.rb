class AddMonthlyPointToGamifications < ActiveRecord::Migration
  def self.up
    add_column :gamifications, :monthly_point, :integer, :default => 0
    add_column :gamifications, :monthly_ticket_count, :integer, :default => 0
    add_column :gamifications, :next_level, :integer, :default => 0
    add_column :gamifications, :update_at, :date
  end

  def self.down
    remove_column :gamifications, :monthly_point
    remove_column :gamifications, :monthly_ticket
    remove_column :gamifications, :next_level
    remove_column :gamifications, :update_at
  end
end
