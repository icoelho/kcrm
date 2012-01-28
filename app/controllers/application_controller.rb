class ApplicationController < ActionController::Base
   # protect_from_forgery
  
   def authorize_user
     if session[:userId] == nil
        redirect_to "/usuario/login"
     end
  end
  
end
