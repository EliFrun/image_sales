require 'json'
require 'digest'

class ApplicationController < ActionController::API
    include Response
    include ExceptionHandler
    #before_action :ensure_json_request

    def ensure_json_request  
        return if request.format == :json
        render :nothing => true, :status => 406 # only accept json
    end 
end
