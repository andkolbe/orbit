class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update] # only logged in users can edit and update
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def show # GET requests for one user are handled by the show action
    # create an instance variable that can be used as @user in the users/show view
    # the controller reaches out to the model to find the user by the id in the database and then pass that to the view
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Orbit"
      redirect_to @user
    else 
      render 'new'
    end
  end

  def edit # GET request to send you to the edit user page
  end

  def update
    if @user.update(user_params) # only lets you update the fields specified in user_params
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit'
    end

  end

  private

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless @user == current_user
    end

    def user_params # only accept these strong parameters for saving a new user in the database
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
