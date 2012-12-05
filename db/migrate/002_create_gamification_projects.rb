class CreateGamificationProjects < ActiveRecord::Migration
  def change
    create_table :gamification_projects do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :point, default: 0
      t.integer :ticket_count, default: 0
    end
  end
end
