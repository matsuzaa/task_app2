class Borrow < ApplicationRecord
    #モデルの関連付け
    belongs_to :user
    belongs_to :lend

    validates :start_day, presence: true
    validates :end_day, presence: true
    validates :stay, length: { in: 1..31 }
    validates :peoples,presence: true, length: { minimum: 1 }
    validates :total, presence: true
end
