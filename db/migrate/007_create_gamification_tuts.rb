class CreateGamificationTuts < ActiveRecord::Migration
  def change
    create_table :gamification_tuts do |t|
      t.integer :user_id
      t.integer :project_f, default: 0
      t.integer :new_tkt_f, default: 0
      t.integer :edit_tkt_f, default: 0
      t.integer :edit_wiki_f, default: 0
      t.integer :up_image_f, default: 0
      t.integer :rate_member_f, default: 0
    end
  end
end
