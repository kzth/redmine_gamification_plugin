class CreateGamificationUserTuts < ActiveRecord::Migration
  def change
    create_table :gamification_user_tuts do |t|
      t.integer :user_id
      t.integer :tut1_f, default: 0
      t.integer :tut2_f, default: 0
      t.integer :tut3_f, default: 0
      t.integer :tut4_f, default: 0
      t.integer :tut5_f, default: 0
      t.integer :tut6_f, default: 0
      t.integer :tut7_f, default: 0
      t.integer :tut8_f, default: 0
      t.integer :tut9_f, default: 0
      t.integer :tut10_f, default: 0
    end
  end
end
