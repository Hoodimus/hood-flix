class GenresController < ApplicationController

	before_action :require_signin, except: [:index, :show]
	before_action :set_genre, only: [:show, :edit, :update, :destroy]
	before_action :require_admin, except: [:index, :show]
	
	def index
		@genres = Genre.all
	end

	def new
		@genre = Genre.new
	end

	def create
		@genre = Genre.new(genre_params)
  		if @genre.save
  			redirect_to genres_path, notice: "Genre successfully created!"
  		end
  	end

  	def show
  		#@genre = Genre.find(params[:id])
  		@movie_list = @genre.movies
  	end

  	def edit
  		#@genre = Genre.find(params[:id])
	end

	def update
		#@genre = Genre.find(params[:id])
		if @genre.update(genre_params)
			redirect_to genres_path
		end
	end

	def destroy
		#@genre = Genre.find(params[:id])
		@genre.destroy
		redirect_to genres_path, alert: "Genre successfully deleted!"
	end
end

private

	def genre_params
		params.require(:genre).permit(:name, :id)
	end

	def set_genre
  		@genre = Genre.find_by!(slug: params[:id])
	end
