Rails.application.routes.draw do
	root 'homes#top'
	get 'about' => 'homes#about'
	get 'get_genre/new' => 'homes#new', defaults: { format: 'json' }

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
		resources :tourist_spots, only: [:index, :show, :edit, :update, :destroy] do
			resources :reviews, only: [:index, :show, :edit, :update, :destroy]
		end
		resources :users, only: [:index, :show, :edit, :update] do
			collection { post :import }
		end
		resources :genres, only: [:new, :create, :index, :edit, :update, :destroy]
		resources :scenes, only: [:new, :create, :index, :edit, :update, :destroy]
		resources :comments, only: [:edit, :update, :destroy]
  end

	namespace :user do
		resources :tourist_spots, only: [:new, :create, :show, :edit, :update, :destroy] do
			resource :favorites, only: [:create, :destroy]
			resource :wents, only: [:create, :destroy]
			resources :reviews do
				resource :likes, only: [:index, :create, :destroy]
				resources :comments, only: [:create, :edit, :update, :destroy]
			end
			get 'map' => 'tourist_spots#map'
			get 'images' => 'tourist_spots#images'
			put :sort
		end

		resources :users, only: [:show, :edit, :update, :destroy]
    resources :messages, only: [:create]
    resources :rooms, only: [:create, :show, :index]
		resources :contacts, only: [:new, :create]
		resources :notifications, only: [:index, :destroy]
		resources :coupons, only: [:create, :index]
		resources :events

		get 'user/keyword/search' => 'users#keyword_search'
    post 'follow/:id' => 'relationships#follow', as: 'follow'
    post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
    get 'users/following/:user_id' => 'users#following', as:'following'
		get 'users/follower/:user_id' => 'users#follower', as:'follower'

		get 'favorites' => 'tourist_spots#favorites'
		get 'wents' => 'tourist_spots#wents'
		get 'tourist_spot/keyword/search' => 'tourist_spots#keyword_search'
		get 'tourist_spot/genre/search' => 'tourist_spots#genre_search'
		get 'tourist_spot/scene/search' => 'tourist_spots#scene_search'
		get 'tourist_spot/prefecture/search' => 'tourist_spots#prefecture_search'
		get 'tourist_spot/tag/search' => 'tourist_spots#tag_search'

		get 'my_calendar' => 'events#my_calendar'
		get 'get_genre/children' => 'tourist_spots#get_genre_children', defaults: { format: 'json' }
		get 'get_genre/grandchildren' => 'tourist_spots#get_genre_grandchildren', defaults: { format: 'json' }
	end
end
