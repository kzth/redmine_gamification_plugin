# coding: utf-8

#Rails.configuration.to_prepare do
#  unless Issue.included_modules.include? IssuePatch
#    Issue.send(:include, IssuePatch)
#  end
#
#  unless WikiContent.included_modules.include? WikiPatch
#    WikiContent.send(:include, WikiPatch)
#  end
#end

Redmine::Plugin.register :gamification do
  name 'Gamification plugin'
  author 'hrtkzt'
  description 'This plugin is gamification plugin in redmine'
  version '0.0.1'

  permission :gamification, {:gamification => [:project]}, :public => true

  menu :top_menu, :gamification, {controller: 'gamification', action: 'index'}, :caption => 'ゲーミフィケーション'
  menu :project_menu, :project_gamification, {controller: 'gamification', action: 'project'}, caption: 'ステータス', param: :project_id 
end

require_dependency 'hooks/controller_issues_edit_after_save_hook.rb'
require_dependency 'hooks/controller_issues_new_after_save_hook.rb'
require_dependency 'hooks/controller_wiki_edit_after_save_hook.rb'
