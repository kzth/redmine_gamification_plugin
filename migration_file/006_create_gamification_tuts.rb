class CreateGamificationTuts < ActiveRecord::Migration
  def change
    create_table :gamification_tuts do |t|
      t.string :desc
    end
  end
end
