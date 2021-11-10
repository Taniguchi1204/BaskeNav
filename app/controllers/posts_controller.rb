class PostsController < ApplicationController
  protect_from_forgery :except => [:destroy]

  def index
     # フォローしているユーザーのidを取得
    user_ids = current_user.relationships.pluck(:followed_id)
    # 自身のidを一覧に追加する
    user_ids.push(current_user.id)
    # 自信とフォローしているユーザーの投稿は新規投稿順で取得
    @posts   = Post.where(user_id: user_ids).order(created_at: :desc)
  end

  def show
    @post          = Post.find(params[:id])
    @comment       = PostComment.new
    @post_comments = @post.post_comments.order(created_at: :desc)
    lat = @post.post_place.latitude # 経度
    lng = @post.post_place.longitude # 緯度

    # googelmap.jsで使用する変数
    gon.lat = lat
    gon.lng = lng
  end

  def new
    @post = Post.new
    @post.build_post_place #投稿内容の場所を指定
  end

  def create
    @post         = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      if @post.image # 写真があればAPIを使用しタグ付けを行う
        tags_en = Vision.get_image_data(@post.image)
        tags_en.each do |tag|
          @post.tags.create(name: tag)
        end
      end
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
      params.require(:post).permit(:content,
                                   :image,
                                   post_place_attributes: [:address]
                                  )
    end
end
