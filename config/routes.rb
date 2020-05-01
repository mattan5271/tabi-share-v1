Rails.application.routes.draw do
	root 'homes#top'
  get 'about' => 'homes#about'

	devise_for :admins, controllers: {
		sessions:      'admins/sessions',
	}
	devise_for :users, controllers: {
		sessions:      'users/sessions',
		passwords:     'users/passwords',
		registrations: 'users/registrations',
		omniauth_callbacks: 'users/omniauth_callbacks'
  }

	namespace :admin do
		get 'top' => 'homes#top'
		resources :users, only: [:index, :show, :edit, :update]
		resources :tourist_spots, only: [:index, :show, :edit, :update, :destroy]
		resources :genres, only: [:new, :create, :index, :edit, :update, :destroy]
		resources :scenes, only: [:new, :create, :index, :edit, :update, :destroy]
		resources :reviews, only: [:index, :show, :destroy]
		resources :comments, only: [:destroy]
  end

	namespace :user do
		resources :users, only: [:show, :edit, :update]
		resources :tourist_spots
		resources :tourist_spot_likes, only: [:create, :destroy]
		resources :wents, only: [:create, :destroy]
		resources :reviews
		resources :comments, only: [:new, :create, :edit, :update, :destroy]
    resources :review_likes, only: [:create, :destroy]
    resources :contacts, only: [:new, :create]
	end
end
