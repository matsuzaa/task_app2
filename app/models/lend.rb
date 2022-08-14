class Lend < ApplicationRecord
    #ActiveHashとのアソシエーション
    extend ActiveHash::Associations::ActiveRecordExtensions

    #画像のアソシエーション
    has_many_attached :images

    #モデルの関連付け
    belongs_to :user
    has_many :borrows       #物件が消えても予約履歴は残る

    validates :name, presence: true, length: { maximum: 50 }
    validates :address, presence: true
    validates :price, presence: true
    validates :content, length: { maximum: 500 }
    #都道府県格納用、"---"選択時は保存を許可しない
    belongs_to :prefecture
    validates :prefecture_id, numericality: { other_than: 0 }

end
