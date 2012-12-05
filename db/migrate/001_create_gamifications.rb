class CreateGamifications < ActiveRecord::Migration
  def change
    create_table :gamifications do |t|
      t.integer :user_id
      t.integer :point, default: 0
      t.integer :level, default: 1
      t.integer :ticket_count, default: 0
    end
  end
end
