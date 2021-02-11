class UsersController < ApplicationController
	before_action :require_signin, except: [:new, :create]
	before_action :require_correct_user, only: [:edit, :update]
	before_action :require_admin, only: [:destroy]
	before_action :set_user, only: [:show, :edit, :update, :destroy]

	def index
		@users = User.not_admins
	end

	def show
		@reviews = @user.reviews
		@favorite_movies = @user.favorite_movies
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to @user, notice: "Account successfully created!"
		else
			render :new
		end
	end
	#defines the user with id parameter in the url to populate edit form
	def edit
	end
	# uses the submitted form data to update the user in db
	def update
		if @user.update(user_params)
			redirect_to @user, notice: "Account successfully updated!"
		else
			render :edit
		end
	end

	def destroy
		@user.destroy
		redirect_to root_url, alert: "Account successfully deleted!"
	end


	private
	# 
	def user_params
		params.require(:user).
		permit(:username, :name, :email, :password, :password_confirmation)
	end

	def require_correct_user
		@user = User.find_by!(slug: params[:id])
		redirect_to root_url unless current_user?(@user)
	end

	def set_user
		@user = User.find_by!(slug: params[:id])
	end
end
