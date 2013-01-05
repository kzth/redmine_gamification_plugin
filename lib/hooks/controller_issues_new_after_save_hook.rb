require 'gamification_util.rb'

module Hooks
  class ControllerIssuesNewAfterSaveHook < Redmine::Hook::ViewListener

    include GamificationUtil

    def controller_issues_new_after_save(context={})
      if context[:params] && context[:params][:issue]
        current_user_id = User.current.id
        project_id = Project.find_by_identifier(context[:params][:project_id]).id

        # gamification_user_update
        if Gamification.exists?({user_id: current_user_id})
          user = Gamification.find_by_user_id(current_user_id)
          user_badge = GamificationBadge.find_by_user_id(current_user_id)

          # initializei monthly
          if user.differ_month
            user.monthly_init
          end

          # user update
          user.up_point(20)
          user.up_ticket_count

          # check level
          old_lvl = user.level
          new_lvl, user.next_level = decide_level(user.point)
          user.level = check_level(old_lvl, new_lvl)

          # ticket count up
          new_badge = check_ticket_badge(user_badge, user.ticket_count)

          # update user badge
          new2_badge = check_level_badge(new_badge, user.level)
          new2_badge.save

          user.update_date
          user.save
        end

        # gamification_project_update
        if GamificationProject.exists?({user_id: current_user_id, project_id: project_id})
          user_project = GamificationProject.find_by_user_id_and_project_id(current_user_id, project_id)
          user_project.up_point(20)
          user_project.up_ticket_count
          user_project.save
        end

        # GamificationTut DBの更新
        if GamificationTut.exists?({user_id: current_user_id})
          GamificationTut.update_flag(current_user_id, :new_tkt_f)
        end
      end

      return ''
    end
  end
end
