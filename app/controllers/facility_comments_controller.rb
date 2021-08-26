class FacilityCommentsController < ApplicationController

  def create
    @facility = Facility.find(params[:facility_id])
    @facility_comments  = @facility.facility_comments.order(created_at: :DESC)
    @comment = current_user.facility_comments.new(facility_comment_params)
    @comment.facility_id = @facility.id
    @comment.save
  end

  def destroy
    @facility = Facility.find(params[:facility_id])
    @facility_comments  = @facility.facility_comments.order(created_at: :DESC)
    comment = FacilityComment.find_by(id: params[:id], facility_id: params[:facility_id])
    comment.destroy
  end

  private

  def facility_comment_params
    params.require(:facility_comment).permit(:comment, :rate)
  end
end
