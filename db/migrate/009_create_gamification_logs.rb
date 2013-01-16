class CreateGamificationLogs < ActiveRecord::Migration
  def change
    create_table :gamification_logs do |t|
      t.integer :issue_id
      t.integer :from_user_id
      t.integer :to_user_id
      t.string :rating_medal
      t.date :updated_at
    end
  end
end