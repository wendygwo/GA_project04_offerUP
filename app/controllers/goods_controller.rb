class GoodsController < ApplicationController
  respond_to :json
  before_action :set_good, only: [:show, :edit, :update, :destroy]
  # Before allowing access to goods pages(except show), make sure a user is logged in
  before_filter :authenticate, :except => [:show, :index]

  def search
    goodsArray = []
    friendsArray = []
    # narrowing down goods by proximity in miles, if location supplied by user
    if params[:location] != ''
      @goods = Good.near(params[:location], 20)
    else
      #if location supplied by user, then return all goods from all locations 
      @goods = Good.all
    end
    # Create array of id of goods within search proximity to array, to be used in Searchkick search
    @goods.each do |g|
      goodsArray.push(g.id)
    end
    # array of current_user's friend_ids, to be used in Searchkick search
    friendsArray = current_user.friendships.pluck(:friend_id)
    # If no name search parameter present, then search all goods
    if !params[:name].present?
      params[:name] = '*'
    end
    # search goods based on user input, narrowed down by proximity that belong to current_user's friends
    @goods = Good.search params[:name], 
              fields: [{name: :word_middle},
              {description: :word_middle}
            ],
              where:{
                id: goodsArray,
                user_id: friendsArray
              }
    # Reset params[:name] to blank field, so it doesn't show up in the search form the user sees
    params[:name]=''
  end
  
  def index
    @goods = Good.all
  end

  def show
  end

  def new
    @good = Good.new
  end

  def edit
  end

  def create
    @good = Good.new(good_params)
    @good.latitude = @good.user.latitude
    @good.longitude = @good.user.longitude
    @good.city = @good.user.city
    @good.state = @good.user.state
    @good.zip_code = @good.user.zip_code
    respond_to do |format|
      if @good.save
        format.html { redirect_to @good, notice: 'Good was successfully created.' }
        format.json { render :show, status: :created, location: @good }
      else
        format.html { render :new }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @good.update(good_params)
        format.html { redirect_to @good, notice: 'Good was successfully updated.' }
        format.json { render :show, status: :ok, location: @good }
      else
        format.html { render :edit }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @good.destroy
    respond_to do |format|
      format.html { redirect_to goods_url, notice: 'Good was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_good
      @good = Good.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def good_params
      params.require(:good).permit(:name, :description, :latitude, :longitude, :user_id, :photo)
    end
end
