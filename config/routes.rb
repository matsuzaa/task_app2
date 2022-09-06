Rails.application.routes.draw do
  get 'searches/index'
  get 'borrows/index'
  get 'lends/index'
  get 'sessions/new'
  root 'inns#index'   #TOP画面固定
  post 'users/complete'   #ユーザ登録完了画面
  post 'borrows/confirm'   #予約確認画面
  post 'borrows/back'   #確認画面から予約画面に戻る
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #ログインセッション用
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  resources :inns, :users, :lends, :borrows
end
