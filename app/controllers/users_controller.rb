class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show # GET requests for one user are handled by the show action
    # create an instance variable that can be used as @user in the users/show view
    # the controller reaches out to the model to find the user by the id in the database and then pass that to the view
    @user = User.find(params[:id])
  end

  def create
    @user = User.new[params[:user]]
    if @user.save
      # Handle a successful save
    else 
      render 'new'
    end
  end
end
