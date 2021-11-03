class FacilityCommentsController < ApplicationController

  def create
    @facility            = Facility.find(params[:facility_id])
    @comment             = current_user.facility_comments.new(facility_comment_params)
    @comment.facility_id = @facility.id
    @comment.save
    
    
    # 非同期時に必要なインスタンス変数
    @comment_new         = FacilityComment.new
    @facility_comments   = @facility.facility_comments.order(created_at: :DESC)
    
    # 施設にコメンがある場合はグラフデータを取得する(非同期用)
    if @facility_comments.present?
      @graph = FacilityComment.rate_persent(@facility_comments)
    end
  end

  def destroy
    @facility           = Facility.find(params[:facility_id])
    comment             = FacilityComment.find_by(id: params[:id], facility_id: params[:facility_id])
    comment.destroy
    
    
    # 非同期時に必要なインスタンス変数
    @comment_new        = FacilityComment.new
    @facility_comments  = @facility.facility_comments.order(created_at: :DESC)
    
    # 施設にコメンがある場合はグラフデータを取得する(非同期用)
    if @facility_comments.present?
      @graph = FacilityComment.rate_persent(@facility_comments)
    end
  end

  private

  def facility_comment_params
    params.require(:facility_comment).permit(:comment, :rate)
  end
end
