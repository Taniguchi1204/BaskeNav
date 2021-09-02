class PostsController < ApplicationController
  protect_from_forgery :except => [:destroy]

  def index
    user_ids = current_user.relationships.pluck(:followed_id) # フォローしているユーザーのidを取得
    user_ids.push(current_user.id) # 自身のidを一覧に追加する
    @posts   = Post.where(user_id: user_ids).order(created_at: :desc)
  end

  def show
    @post          = Post.find(params[:id])
     @tags = Vision.get_image_data(@post.image)
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
      tags_en = Vision.get_image_data(@post.image)
      tags_en.each do |tag|
        # APIのURL作成
        api_url = "https://translation.googleapis.com/language/translate/v2?key=#{ENV['GOOGLE_API_KEY']}"


        # APIリクエスト用のJSONパラメータ
        params = {
                  "q": "#{tag}",
                  "source": "en",
                  "target": "ja",
                  "format": "text"
                }.to_json

        # Google Cloud Vision APIにリクエスト
        uri = URI.parse(api_url)
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true
        request = Net::HTTP::Post.new(uri.request_uri)
        request['Content-Type'] = 'application/json'
        response = https.request(request, params)
        response_body = JSON.parse(response.body)
        # APIレスポンス出力
        tag_ja = response_body["data"]["translations"][0]["translatedText"]
        @post.tags.create(name: tag_ja)
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
      params.require(:post).permit(
        :content,
        :image,
        post_place_attributes: [:address]
      )
    end
end
