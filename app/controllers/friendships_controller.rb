class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :edit, :update, :destroy]

  # Before allowing access to friendships pages, make sure a user is logged in
  before_filter :authenticate

  # # GET /friendships
  # # GET /friendships.json
  # def index
  #   @friendships = Friendship.all
  # end

  # # GET /friendships/1
  # # GET /friendships/1.json
  # def show
  # end

  # # GET /friendships/new
  # def new
  #   @friendship = Friendship.new
  # end

  # # GET /friendships/1/edit
  # def edit
  # end

  # POST /friendships
  # POST /friendships.json
  def create
    # raise params.inspect
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    # Friendship.new(friendship_params)
    friendee = User.where(id: params[:friend_id]).first
    inverse_friendship = friendee.friendships.build(:friend_id => current_user.id)

    respond_to do |format|
      if @friendship.save && inverse_friendship.save
        UserMailer.friend_added(current_user, friendee).deliver_now
        format.html { redirect_to user_path(current_user), notice: 'Friendship was successfully created.' }
        format.json { render :show, status: :created, location: @friendship }
      else

        format.html { render :new }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # # PATCH/PUT /friendships/1
  # # PATCH/PUT /friendships/1.json
  # def update
  #   respond_to do |format|
  #     if @friendship.update(friendship_params)
  #       format.html { redirect_to @friendship, notice: 'Friendship was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @friendship }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @friendship.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    # Find friendship to destroy
    @friendship = current_user.friendships.find(params[:id])
    # Find corresponding inverse friendship to destroy
    @friendship_inverse = Friendship.where(user_id:@friendship.friend_id, friend_id: current_user.id).first

    # Destroy friendship and corresponding inverse friendship
    @friendship.destroy
    @friendship_inverse.destroy

    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: 'Friendship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id)
    end
end
