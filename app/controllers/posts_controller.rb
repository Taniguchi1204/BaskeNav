class PostsController < ApplicationController
  def new
    @post = Post.new
    @post.build_post_place
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save!
      redirect_to root_path
    else
      redirect_to new_post_path
    end
  end

  def show
    @post         = Post.find(params[:id])
    @comment      = PostComment.new
    @post_comments = @post.post_comments
    lat = @post.post_place.latitude
    lng = @post.post_place.longitude

    # googelmap.jsで使用する変数
    gon.lat = lat
    gon.lng = lng
  end

  def post_params
    params.require(:post).permit(
      :content,
      :image,
      post_place_attributes: [:address]
    )
  end
end
