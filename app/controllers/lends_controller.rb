class LendsController < ApplicationController
  before_action :login_user

  def index
    @q = Lend.ransack(params[:q])
    @lends = @q.result(distinct: true)
  end

  def new
    @lend = Lend.new
  end

  def create
    @lend = Lend.new(lend_params)
    @lend.prefect = @lend.prefecture.name
    if @lend.save
      flash[:notice] = "物件情報を登録しました"
      redirect_to @user
    else
      flash.now[:notice] = "登録に失敗しました"
      render "new"
    end
  end

  def show
    @lend = Lend.find(params[:id])
    session[:lend_id] = @lend.id
  end

  def edit
    @lend = Lend.find(params[:id])
  end

  def update
    @lend = Lend.find(params[:id])
    @lend.prefect = @lend.prefecture.name
    #チェック画像を削除
    if params[:lend][:image_ids]
      params[:lend][:image_ids].each do |image_id|
        image = @lend.images.find(image_id)
        image.purge
      end
    end

    if @lend.update(lend_params)
      flash[:notice] = "物件情報を更新しました"
      redirect_to edit_lend_path
    else
      flash.now[:notice] = "更新に失敗しました"
      redirect_to edit_lend_path
    end
  end

  def destroy
    @lend = Lend.find(params[:id])
    flash[:notice] = "物件情報：#{@lend.name}　を削除しました"
    @lend.destroy
    redirect_to :user
  end

  private
  def lend_params
    params.require(:lend).permit(:name, :prefect, :address, :price, :content, :prefecture_id, :user_id, images:[])
  end

  def login_user    #before
    @user = current_user
  end
end
