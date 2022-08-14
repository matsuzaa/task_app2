class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user     #sessions_helper.rbにて定義
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user   #sessions_helper.rbにて定義(userをデフォルトurlに指定)
    else
      flash.now[:notice] = "ログインに失敗しました"
      render 'new'
    end
  end

  def destroy
    flash.now[:notice] = "ログアウトしました。"
    log_out     #sessions_helper.rbにて定義
    redirect_to root_url
  end
end
