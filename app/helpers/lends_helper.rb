module LendsHelper

    #該当userの貸し物件一覧を格納
    def user_lend
        @user = current_user
        @lend = Lend.new
        @lends = @user.lends
    end
end
