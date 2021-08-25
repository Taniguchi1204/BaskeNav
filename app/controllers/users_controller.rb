class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all

    # フォローしていた場合はチャットができる
    if current_user.following?(@user)
      rooms = current_user.entries.pluck(:room_id)
      user_rooms = Entry.find_by(user_id: @user.id, room_id: rooms)
      room = user_rooms.room
      @messages = room.messages
      @message = Message.new(room_id: room.id)
    end
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
