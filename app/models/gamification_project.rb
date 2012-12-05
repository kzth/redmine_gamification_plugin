class GamificationProject < ActiveRecord::Base
  unloadable

#  belongs_to :member
  belongs_to :user, foreign_key: 'user_id'
  
  def up_point(point)
    self.point += point
  end

  def up_ticket_count
    self.ticket_count += 1
  end
end
