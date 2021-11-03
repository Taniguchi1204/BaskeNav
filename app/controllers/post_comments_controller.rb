class PostCommentsController < ApplicationController

  def create
    @post            = Post.find(params[:post_id])
    @comment         = current_user.post_comments.new(post_comment_params)
    @comment.post_id = @post.id
    @comment.save
    
    # 非同期通信で使用するインスタンス変数
    @post_comments   = @post.post_comments.order(created_at: :DESC)
  end

  def destroy
    @post   = Post.find(params[:post_id])
    comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
    comment.destroy
    
    # 非同期通信で使用するインスタンス変数
    @post_comments = @post.post_comments.order(created_at: :DESC)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
