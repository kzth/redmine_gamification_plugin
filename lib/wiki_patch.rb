require_relative "./gamification_util.rb"
include GamificationUtil

module WikiPatch

  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include, InstanceMethods)

    base.class_eval do
      unloadable

      after_save :gamification_wiki_update

    end
  end

  module ClassMethods
  end

  module InstanceMethods
    
    def gamification_wiki_update
      current_user_id = User.current.id
      if Gamification.exists?({user_id: current_user_id})
        user = Gamification.find_by_user_id(current_user_id)
        GamificationUtil::up_point(user, 5)
        user.save
      end
    end

  end
end
