class Admin::ScenesController < ApplicationController
	before_action :authenticate_admin!
	before_action :set_scene, only: [:edit, :update, :destroy]

	def index
		@scene = Scene.new
		@scenes = Scene.all.page(params[:page]).per(10)
	end

	def create
		@scene = Scene.new(scene_params)
		if @scene.save
			redirect_to admin_scenes_path(@scene)
		else
			@scenes = Scene.all.page(params[:page]).per(10)
			render "index"
		end
	end

  def edit
  end

  def update
		if @scene.update(scene_params)
			redirect_to admin_scenes_path
		else
			render "edit"
		end
  end

	def destroy
		@scene.destroy
		redirect_to admin_scenes_path
	end

	private

		def set_scene
			@scene = Scene.find(params[:id])
		end

		def scene_params
			params.require(:scene).permit(:name)
		end

end
