require 'redmine'
require_dependency 'issue'

unless Issue.included_modules.include? IssueCallbacksAfterUpdate
  Issue.send(:include, IssueCallbacksAfterUpdate)  	
end

Redmine::Plugin.register :post_request_when_issue_updates_plugin do
  name 'Post Request When Issue Updates Plugin plugin'
  author 'Alexey Kondratenko'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  settings :default => {'empty' => true}, :partial => 'settings/post_request_settings'
end
