class CreateGamificationBadges < ActiveRecord::Migration
  def change
    create_table :gamification_badges do |t|
      t.integer :user_id
      t.integer :lvl5_badge, default: 0
      t.integer :lvl10_badge, default: 0
      t.integer :lvl50_badge, default: 0
      t.integer :lvl100_badge, default: 0
      t.integer :tkt10_badge, default: 0
      t.integer :tkt50_badge, default: 0
      t.integer :tkt100_badge, default: 0
      t.integer :tkt500_badge, default: 0
      t.integer :tkt1000_badge, default: 0
    end
  end
end
