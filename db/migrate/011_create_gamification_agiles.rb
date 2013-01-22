class CreateGamificationAgiles < ActiveRecord::Migration
  def change
    create_table :gamification_agiles do |t|
      t.integer :user_id
      t.integer :af1, default: 0
      t.integer :af2, default: 0
      t.integer :af3, default: 0
      t.integer :af4, default: 0
      t.integer :af5, default: 0
      t.integer :af6, default: 0
      t.integer :af7, default: 0
      t.integer :af8, default: 0
      t.integer :af9, default: 0
      t.integer :af10, default: 0
      t.integer :bf1, default: 0
      t.integer :bf2, default: 0
      t.integer :bf3, default: 0
      t.integer :bf4, default: 0
      t.integer :bf5, default: 0
      t.integer :bf6, default: 0
      t.integer :bf7, default: 0
      t.integer :bf8, default: 0
      t.integer :bf9, default: 0
      t.integer :bf10, default: 0
      t.integer :cf1, default: 0
      t.integer :cf2, default: 0
      t.integer :cf3, default: 0
      t.integer :cf4, default: 0
      t.integer :cf5, default: 0
      t.integer :cf6, default: 0
      t.integer :cf7, default: 0
      t.integer :cf8, default: 0
      t.integer :cf9, default: 0
      t.integer :cf10, default: 0
    end
  end
end
