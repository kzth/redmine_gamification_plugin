class GamificationLog < ActiveRecord::Base
  unloadable

  belongs_to :user, foreign_key: 'from_user_id'
end
