class AddGoalToGamifications < ActiveRecord::Migration
  def self.up
    add_column :gamifications, :goal, :string
  end

  def self.down
    remove_column :gamifications, :goal
  end
end
