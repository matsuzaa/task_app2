module BorrowsHelper
    #該当userの予約一覧を収納
    def user_borrow
        @user = current_user
        @borrow = Borrow.new
        @borrows = @user.borrows
    end

    #該当物件の予約一覧を収納
    def lend_borrow
        @lend = Lend.find(params[:id])
        @borrow = Borrow.new
        @borrows = @lend.borrows 
    end

    #借りたユーザの名前を格納
    def borrow_user(user_id)
        @user = User.find(user_id)
        @user_name = @user.name
    end

    #一人当たりの宿泊料
    def people_total
        @borrow = session[:borrow]
        @people_total = @borrow.total / @borrow.peoples
    end
end
