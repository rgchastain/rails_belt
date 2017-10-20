class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :authorized, only: [:edit, :update, :destroy]

  def new
  
  end

  def create
  	@user = User.new(user_params)
  	
  	if @user.save

  		session[:user_id] = @user.id
  		
  		return redirect_to ideas_path
  	end

  	flash[:errors] = @user.errors.full_messages

  	return redirect_to :back
  end

  def show
  	@user = User.find(params[:id])

  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])

  	if @user.update(user_params)
		flash[:notice] = ["Successfully updated user"]
		return redirect_to ideas_path
 	end

 	flash[:errors] = @user.errors.full_messages
	return redirect_to :back
	end

  def destroy
  	@user = User.find(params[:id])

		@user.delete

		session.clear

		flash[:notice] = ["Deleted account"]

		return redirect_to new_user_path
  end

  private
  	def user_params
  		params.require(:user).permit(:name, :alias, :email, :password, :password_confirmation)
  	end
  	# def authorized
   #    return redirect_to ideas_path(current_user) unless current_user.id == params[:id].to_i
   #  end
end
