class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  
# returns nil if user is not logged in
  def current_user
    User.where(id: session["user_id"]).first
  end
  
  # Check if user is logged in before allowing them access to certain views
  # See user and goods controllers to see exact views that are restricted
  def authenticate
  	if session["user_id"].nil?
  		flash[:notice] = 'You must be logged in to complete this action.'
  		redirect_to :controller => 'sessions', :action => 'new'
  	end
  end
end
