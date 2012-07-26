class AdminSessionsController < Devise::SessionsController
  layout "login"
  skip_before_filter :authenticate_user!
  
end
