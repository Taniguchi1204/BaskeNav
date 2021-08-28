class PostsController < ApplicationController

  def index
    user_ids = current_user.relationships.pluck(:followed_id) # フォローしているユーザーのidを取得
    user_ids.push(current_user.id) # 自身のidを一覧に追加する
    @posts   = Post.where(user_id: user_ids).order(created_at: :desc)
  end

  def show
    @post          = Post.find(params[:id])
    @comment       = PostComment.new
    @post_comments = @post.post_comments.order(created_at: :DESC)
    lat = @post.post_place.latitude
    lng = @post.post_place.longitude

    # googelmap.jsで使用する変数
    gon.lat = lat
    gon.lng = lng
  end

  def new
    @post = Post.new
    @post.build_post_place
  end

  def create
    @post         = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      render new_post_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
  end


  private

    def post_params
      params.require(:post).permit(
        :content,
        :image,
        post_place_attributes: [:address]
      )
    end
end
