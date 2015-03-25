class SessionsController < ApplicationController
  def new
    if current_user != nil
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  def create
    # finds the user by email. Returns entire object. 
    u = User.where(email: params[:user][:email]).first
    if u != nil && u.authenticate(params[:user][:password])
      # if user is authenticated, creates cookie in browser. Session is a rails specific idea.
      # Cookie only sticks if redirect_to renders a complete page. 
      session["user_id"] = u.id.to_s
      redirect_to user_path(u.id)
    else 
      flash[:notice] = "Login Failed. Please Try Again."
      redirect_to new_sessions_path
    end
  end

  def destroy
    session.destroy
    redirect_to new_sessions_path
  end
end