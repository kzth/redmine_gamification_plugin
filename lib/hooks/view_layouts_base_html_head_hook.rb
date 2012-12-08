module Hooks
  class ViewLayoutsBaseHtmlHeadHook < Redmine::Hook::ViewListener
    def view_layouts_base_html_head(context={})
      if context[:controller]

        return javascript_include_tag 'gamification.js', plugin: 'gamification'

      else
        return ''
      end
    end
  end
end
