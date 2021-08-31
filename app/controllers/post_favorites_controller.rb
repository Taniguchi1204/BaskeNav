class PostFavoritesController < ApplicationController

  def index
    @user  = User.find(params[:user_id])
    @posts = @user.post_contents

    @user_followers  = @user.followers
    @user_followings = @user.followings
  end

  def create
    @post    = Post.find(params[:post_id])
    favorite = current_user.post_favorites.new(post_id: @post.id)
    favorite.save
  end

  def destroy
    @post    = Post.find(params[:post_id])
    favorite =  current_user.post_favorites.find_by(post_id: @post.id)
    favorite.destroy
  end
end
