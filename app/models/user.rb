class User < ApplicationRecord
    attr_accessor :remember_token

    #icon画像のアソシエーション
    has_one_attached :icon

    #モデルの関連付け
    has_many :lends, dependent: :destroy        #ユーザが消えたら物件も消える
    has_many :borrows, dependent: :destroy      #ユーザが消えたら予約履歴も消える

    #メールアドレス保存時に小文字に変換
    before_save { self.email = email.downcase }

    #バリデーション
    validates :name, presence: true, length: { maximum: 30 }
    validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, length: { maximum: 255 }
    validates :introduction, length: { maximum: 200 }
         
    #セキュアパスワードの実装
     has_secure_password
    validates :password, presence: true, length: { in: 6..10 }, allow_nil: true

    #渡された文字列をハッシュ値に変換
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    #トークン生成
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    #永続セッション用にユーザをDBに登録
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    #トークンがダイジェストと一致した場合にtrueを返す
    def authenticated?(remember_token)
        return false if remember_digest.nil?        #remember_digestがnilの時falseを返す
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    #ユーザのログイン情報を破棄する
    def forget
        update_attribute(:remember_digest, nil)
    end
end
