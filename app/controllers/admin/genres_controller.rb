class Admin::GenresController < ApplicationController
	before_action :authenticate_admin!
	before_action :set_genre, only: [:edit, :update, :destroy]

	def index
		@genre = Genre.new
		@genres = Genre.all.page(params[:page]).per(10)
	end

	def create
		@genre = Genre.new(genre_params)
		if @genre.save
			redirect_to admin_genres_path(@genre)
		else
			@genres = Genre.all.page(params[:page]).per(10)
			render "index"
		end
	end

  def edit
  end

  def update
		if @genre.update(genre_params)
			redirect_to admin_genres_path
		else
			render "edit"
		end
  end

	def destroy
		@genre.destroy
		redirect_to admin_genres_path
	end

	private

		def set_genre
			@genre = Genre.find(params[:id])
		end

		def genre_params
			params.require(:genre).permit(:name, :image)
		end

end
