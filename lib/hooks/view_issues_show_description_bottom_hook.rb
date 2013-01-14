module Hooks
  class ViewIssuesShowDescriptionBottomHook < Redmine::Hook::ViewListener
    render_on :view_issues_show_description_bottom,
              :partial => 'hooks/gamification/view_issues_show_description_bottom',
              :layout => false
  end
end
