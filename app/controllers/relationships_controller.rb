class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    rooms      = current_user.entries.pluck(:room_id)
    user_rooms = Entry.find_by(user_id: @user.id, room_id: rooms)

    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      Entry.create(user_id: current_user.id, room_id: @room.id)
      Entry.create(user_id: @user.id, room_id: @room.id)
    end
    @user_followings         = @user.followings
    @user_followers          = @user.followers
    @current_user_followings = current_user.followings
    @current_user_followers  = current_user.followers
  end

  def destroy
    current_user.unfollow(params[:user_id])
    @user                    = User.find(params[:user_id])
    @user_followings         = @user.followings
    @user_followers          = @user.followers
    @current_user_followings = current_user.followings
    @current_user_followers  = current_user.followers
  end

end
