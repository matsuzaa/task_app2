FactoryBot.define do
  factory :borrow do
    user_id { 1 }
    lend_id { 1 }
    start_day { "2022-08-13" }
    end_day { "2022-08-13" }
    stay { 1 }
    peoples { 1 }
    total { 1 }
  end
end
