class CreateGamificationMedals < ActiveRecord::Migration
  def change
    create_table :gamification_medals do |t|
      t.integer :user_id
      t.integer :thank_medal, default: 0
      t.integer :smile_medal, default: 0
      t.integer :nice_medal, default: 0
      t.integer :hot_medal, default: 0
      t.integer :comm_medal, default: 0
      t.integer :grow_medal, default: 0
      t.integer :monthly_thank_medal, default: 0
      t.integer :monthly_smile_medal, default: 0
      t.integer :monthly_nice_medal, default: 0
      t.integer :monthly_hot_medal, default: 0
      t.integer :monthly_comm_medal, default: 0
      t.integer :monthly_grow_medal, default: 0
    end
  end
end
