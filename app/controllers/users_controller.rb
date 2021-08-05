class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
  end

  def edit
    @user = User.find_by(id: current_user)
  end

  def update
    @user = User.find_by(id: current_user)
    @user.update(user_params)
    redirect_to @user
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :phone_number, :user_image, :introduce)
    end
end
