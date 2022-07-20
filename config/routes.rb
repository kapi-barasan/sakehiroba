Rails.application.routes.draw do

  #サーバー起動時の画面
  root to: "homes#top"

  #会員側のdevise
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  #ゲストログインの記述
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  #管理者側のdevise
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }


  scope module: :public do
    resources :users do
      collection do
        patch "quit"
      end
    end

    resources :drinks do
      resources :drink_comments, only: [:create, :destroy]
      resources :favorites, only: [:create, :destroy]
      collection do
        get 'search'
      end
    end
  end

  namespace :admin do
    resources :users
    resources :drinks
  end

end
