#Add callback after_update
module IssueCallbacksAfterUpdate
  def self.included(base) # :nodoc:
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)

    # Same as typing in the class 
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
      after_update :post_request      
    end
  end
  
  module ClassMethods    
  end
  
  module InstanceMethods
    def post_request
      begin
        config_uri = Setting.plugin_post_request_when_issue_updates_plugin["uri_for_post_request"]
        uri_string = (config_uri.nil? ? 'http://0.0.0.0:4567/' : config_uri)
        uri = URI(uri_string)
        http = Net::HTTP.new(uri.host, uri.port)
        #http doesn't wait response 
        http.read_timeout = 0
        
        params = {issueid: self.id, userid: User.current.id, datetime: self.updated_on}.to_json
        json_headers = {"Content-Type" => "application/json", "Accept" => "application/json"}
        http.post(uri.path, params, json_headers)
      rescue Exception => msg 
      end  
    end
  end    
end