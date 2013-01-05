class GamificationTut < ActiveRecord::Base
  unloadable

  def self.update_flag(user_id, flag)
    user_tut= self.find_by_user_id(user_id)
    if(user_tut[flag] == 0)
      user_tut.update_attribute(flag, 1)
    end
  end
end
