class UsersController < ApplicationController
  #beforeアクションを特定のメソッドに有効化
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :correct_user, only: :destroy , unless: proc{ current_user.admin? }
  before_action :admin_user, only: :destroy , unless: proc{ current_user?(@user) }
  
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user    #ユーザ登録時にログイン状態にする処理
       render users_complete_path    #登録成功時は完了画面に移動
    else
      flash.now[:notice] = "登録に失敗しました。再度入力をお願いします。"
      render "new"
    end
  end

  def show
    @user = current_user
  end

  def edit
    #@userはbeforeアクション correct_user にて定義済み
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "更新を反映しました"
      redirect_to :user
    else
      flash.now[:notice] = "更新を反映できませんでした。内容を確認し再度反映してください"
      redirect_to request.referer   #遷移元urlに移動
    end
  end

  def destroy
    @user = User.find(params[:id])
    flash[:notice] = "#{@user.name}さんの情報を削除しました"
    @user.destroy
    if current_user.admin?    #adminの場合のみユーザ一覧に戻す
      redirect_to :users
    else
      redirect_to root_url
    end
  end

  private
    def user_params
      params.require(:user).permit(:id, :name, :email, :password_digest, :password, :password_confirmation, :introduction, :image_name, :icon)
    end

    #beforeアクション
    #ログイン済みユーザか確認
    def logged_in_user
      unless logged_in?
        store_location    #アクセス先を記憶
        flash[:notice] = "ログインを実施してください。"
        redirect_to login_url
      end
    end

    #正しいユーザか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    #管理者か確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end

