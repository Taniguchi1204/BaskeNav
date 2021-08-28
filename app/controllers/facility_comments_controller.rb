class FacilityCommentsController < ApplicationController

  def create
    @comment_new         = FacilityComment.new
    @facility            = Facility.find(params[:facility_id])
    @comment             = current_user.facility_comments.new(facility_comment_params)
    @comment.facility_id = @facility.id
    @comment.save
    @facility_comments   = @facility.facility_comments.order(created_at: :DESC)
    @data                = [['5', FacilityComment.rate_persent(5, @facility_comments)],
                             ['4', FacilityComment.rate_persent(4, @facility_comments)],
                             ['3', FacilityComment.rate_persent(3, @facility_comments)],
                             ['2', FacilityComment.rate_persent(2, @facility_comments)],
                             ['1', FacilityComment.rate_persent(1, @facility_comments)],
                            ]
  end

  def destroy
    @comment_new        = FacilityComment.new
    @facility           = Facility.find(params[:facility_id])
    @facility_comments  = @facility.facility_comments.order(created_at: :DESC)
    comment             = FacilityComment.find_by(id: params[:id], facility_id: params[:facility_id])
    comment.destroy
    @facility_comments  = @facility.facility_comments.order(created_at: :DESC)
    if @facility_comments.present?
      @data             = [['5', FacilityComment.rate_persent(5, @facility_comments)],
                           ['4', FacilityComment.rate_persent(4, @facility_comments)],
                           ['3', FacilityComment.rate_persent(3, @facility_comments)],
                           ['2', FacilityComment.rate_persent(2, @facility_comments)],
                           ['1', FacilityComment.rate_persent(1, @facility_comments)],
                          ]
    end
  end

  private

  def facility_comment_params
    params.require(:facility_comment).permit(:comment, :rate)
  end
end
