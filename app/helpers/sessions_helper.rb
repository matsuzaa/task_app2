module SessionsHelper
    #ログイン
    def log_in(user)
        session[:user_id] = user.id
    end

    #ユーザセッションの永続化
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    #対象ユーザがログイン済みの場合にtrueを返す
    def current_user?(user)
        user == current_user
    end

    #対象ユーザが物件作成ユーザである場合にtrueを返す
    def lend_user?(user)
        @lend = Lend.find(params[:id])
        user.id == @lend.user_id
    end

    #ログイン中の場合に、ログイン中ユーザを格納
    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end

    #ログイン中で有ることを定義
    def logged_in?
        !current_user.nil?      #情報が空白でなければtrueを返す
    end

    #永続的セッションを破棄
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    #ログアウト
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end

    #記憶したURLまたはデフォルト値に転送
    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)     #転送後、転送先urlを削除しループ防止
    end

    #アクセス先URLを記憶
    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end
end

