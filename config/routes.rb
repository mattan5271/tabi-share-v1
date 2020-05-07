Rails.application.routes.draw do
  namespace :user do
    get 'rooms/show'
  end
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
		resources :tourist_spots, only: [:index, :show, :edit, :update, :destroy] do
			resources :reviews, only: [:index, :show, :edit, :update, :destroy]
		end
		resources :genres, only: [:new, :create, :index, :edit, :update, :destroy]
		resources :scenes, only: [:new, :create, :index, :edit, :update, :destroy]
		resources :comments, only: [:edit, :update, :destroy]
  end

	namespace :user do
		resources :users, only: [:show, :edit, :update]
		resources :tourist_spots do
			resource :favorites, only: [:create, :destroy]
			resource :wents, only: [:create, :destroy]
			resources :reviews do
				resource :likes, only: [:index, :create, :destroy]
			end
			get 'map' => 'tourist_spots#map'
		end
		resources :comments, only: [:create, :edit, :update, :destroy]
    resources :messages, only: [:create]
    resources :rooms, only: [:create, :show, :index]
		resources :contacts, only: [:new, :create]
		resources :notifications, only: [:index, :destroy]
		get 'favorite_tourist_spots' => 'favorites#index'
		get 'went_tourist_spots' => 'wents#index'
		get 'keyword/search' => 'tourist_spots#keyword_search'
		get 'genre/search' => 'tourist_spots#genre_search'
		get 'scene/search' => 'tourist_spots#scene_search'
    post 'follow/:id' => 'relationships#follow', as: 'follow'
    post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
    get 'users/following/:user_id' => 'users#following', as:'following'
    get 'users/follower/:user_id' => 'users#follower', as:'follower'
	end
end
