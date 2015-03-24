class GoodsController < ApplicationController
  before_action :set_good, only: [:show, :edit, :update, :destroy]

  def search
    goodsArray = []
    friendsArray = []
    # narrowing down goods by proximity in miles
    @goods = Good.near(params[:location], 20)
    # pushing good_id of goods within search proximity to array
    @goods.each do |g|
      goodsArray.push(g.id)
    end
    # array of current_user's friend_ids
    friendsArray = current_user.friendships.pluck(:friend_id)
    # search goods based on user input, narrowed down by proximity that belong to current_user's friends
    @goods = Good.search params[:name], 
              fields: [{name: :word_middle},
              {description: :word_middle}
            ],
              where:{
                id: goodsArray,
                user_id: friendsArray
              }
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
