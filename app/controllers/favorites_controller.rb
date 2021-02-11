class FavoritesController < ApplicationController
	before_action :set_movie
	before_action :require_signin
	#before_action :set_user
	

	def create
		
		@movie.favorites.create!(user: current_user)
		redirect_to @movie
	end

	def destroy
		favorite = current_user.favorites.find(params[:id])
		favorite.destroy

		
		redirect_to @movie
	end
end


private

	def set_movie
		@movie = Movie.find_by!(slug: params[:movie_id])
	end

	#def set_user
		#@user = User.find_by!(slug: params[:id])
	#end
