class GamificationMedal < ActiveRecord::Base
  unloadable

  belongs_to :gamification, foreign_key: 'user_id'
end
