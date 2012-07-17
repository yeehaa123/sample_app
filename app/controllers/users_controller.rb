class UsersController < ApplicationController
before_filter :signed_in_user,      only: [:index, :edit, :update]
before_filter :correct_user,        only: [:edit, :update]
before_filter :admin_user,          only: [:destroy]
before_filter :non_signed_in_user,  only: [:new, :create]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
	  	render 'new'
    end
	end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    if current_user == User.find(params[:id])
      redirect_to users_path
    else
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed"
      redirect_to users_path
    end
  end

  private
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end

    def non_signed_in_user
      redirect_to root_path unless !signed_in?
    end
end