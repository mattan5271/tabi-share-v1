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
		resources :tourist_spots do
			resource :favorites, only: [:create, :destroy]
			resource :wents, only: [:create, :destroy]
			resources :reviews do
				resource :likes, only: [:index, :create, :destroy]
			end
		end
		resources :comments, only: [:create, :edit, :update, :destroy]
		resources :contacts, only: [:new, :create]
		get 'favorite_tourist_spots' => 'favorites#index'
		get 'went_tourist_spots' => 'wents#index'
	end
end
