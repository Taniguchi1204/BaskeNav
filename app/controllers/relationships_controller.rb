class RelationshipsController < ApplicationController

  def create
    follow_user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    rooms      = current_user.entries.pluck(:room_id)
    user_rooms = Entry.find_by(user_id: follow_user.id, room_id: rooms)
    
    # 初めてフォローした場合のチャット用条件分岐
    unless user_rooms.nil?
      @room = user_rooms.room
    else #（チャット用の中間テーブルの作成）
      @room = Room.new
      @room.save
      Entry.create(user_id: current_user.id, room_id: @room.id)
      Entry.create(user_id: follow_user.id, room_id: @room.id)
    end
    
    @message                 = Message.new(room_id: @room.id)
    @messages                = @room.messages
    
    # ログインしているユーザー情報か訪問先のユーザー情報を取得（非同期用）
    if params[:current_page_id]
      @current_page_id          = params[:current_page_id]
      @user                     = User.find(@current_page_id)
      @user_followings         = @user.followings
      @user_followers          = @user.followers
    else
      @user                     = User.find(params[:user_id])
      @user_followings         = @user.followings
      @user_followers          = @user.followers
    end
    
    @current_user_followings = current_user.followings
    @current_user_followers  = current_user.followers
  end

  def destroy
    current_user.unfollow(params[:user_id])
    @current_page_user       = params[:current_page_id]
    
    # ログインしているユーザー情報か訪問先のユーザー情報を取得（非同期用）
    if params[:current_page_id]
      @current_page_id          = params[:current_page_id]
      @user                     = User.find(@current_page_id)
      @user_followings         = @user.followings
      @user_followers          = @user.followers
    else
      @user                     = User.find(params[:user_id])
      @user_followings         = @user.followings
      @user_followers          = @user.followers
    end

    @current_user_followings = current_user.followings
    @current_user_followers  = current_user.followers
  end

end
