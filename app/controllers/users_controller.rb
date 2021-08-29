class UsersController < ApplicationController
  def show
    @user_id = params[:id]
    @user            = User.find(@user_id)
    @posts           = @user.posts.all
    @user_followers  = @user.followers
    @user_followings = @user.followings

    # フォローしていた場合はチャットができる
    if current_user.following?(@user)
      rooms      = current_user.entries.pluck(:room_id)
      user_rooms = Entry.find_by(user_id: @user.id, room_id: rooms)
      room       = user_rooms.room
      @messages  = room.messages
      @message   = Message.new(room_id: room.id)
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

  def new_guest
    user = User.find_or_create_by(email: 'guest@example.com') do |user|
      user.name         = "ゲスト"
      user.phone_number = "12345678910"
      user.password     = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to user_path(current_user)
  end

  def search_users
    if params[:keyword]
      @search_users = User.search(params[:keyword])
    end
    respond_to do |format|
      format.html
      format.json
    end
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :phone_number, :user_image, :introduce)
    end
end
