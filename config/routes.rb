Rails.application.routes.draw do

  #サーバー起動時の画面
  root to: "homes#top"


  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  #ゲストログインの記述
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end


  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  namespace :public do

    resources :users do
      collection do
        patch "quit"
      end
    end

    resources :drinks do
      collection do
        get 'search'
      end
    end
  end

end
