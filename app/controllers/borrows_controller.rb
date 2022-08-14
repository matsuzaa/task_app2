class BorrowsController < ApplicationController
  before_action :login_user
  before_action :target_lend

  def index
    @borrows = Borrow.all
  end

  def new
    session.delete(:borrow)
    @borrow = Borrow.new
  end

  def back    #確認画面から予約画面に戻る処理
    @borrows = Borrow.new(session[:borrow])
    session.delete(:borrow)
    render "new"
  end

  def confirm   #確認画面作成
    @borrow = Borrow.new(borrow_params)
    @borrow.stay = @borrow.end_day - @borrow.start_day
    if @borrow.stay < 1
        flash[:notice] = "チェックアウトはチェックインより後の日にちに設定してください"
        render "new"
    end
    @borrow.total = @lend.price * @borrow.stay * @borrow.peoples
    session[:borrow] = @borrow
    if @borrow.invalid?
      flash[:notice] = "エラーが発生しました"
      render "new"
    end
  end

  def create
    Borrow.create!(session[:borrow])
    session.delete(:borrow)
    flash[:notice] = "予約しました"
    redirect_to @user
  end

  def show
    @borrow = Borrow.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
    @borrow = Borrow.find(params[:id])
    flash[:notice] = "物件：#{@borrow.name} の予約をキャンセルしました"
    @borrow.destroy
    redirect_to :user
  end

  private
  def borrow_params
    params.permit(:name, :start_day, :end_day, :stay, :peoples, :total, :user_id, :lend_id)
  end

  def login_user    #before
    @user = current_user
  end

  def target_lend   #before
    @lend = Lend.find(session[:lend_id])
  end
end
