class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # Before allowing access to user pages (except index and new), make sure a user is logged in
  before_filter :authenticate, :only => [:edit, :update, :destroy]

  def index
    if current_user != nil
      # Narrow down list of users that can be added as a friend just to users that current user is not already friends with and is not themselves
      friendsArray = current_user.friendships.pluck(:friend_id)
      friendsArray.push(current_user.id)
      @users = User.where.not(id: friendsArray)
    else
      @users = User.all
    end
  end

  def show
    @goods = @user.goods
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        #redirect to owner show page and create session cookie if user successfully created
        session['user_id'] = @user.id.to_s
        UserMailer.welcome(@user.id).deliver
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :zip_code, :city, :state, :latitude, :longitude, :password, :password_confirmation, :photo)
    end
end
