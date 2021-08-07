class FacilityCommentsController < ApplicationController

  def create
    @facility = Facility.find(params[:facility_id])
    @comment = current_user.facility_comments.new(facility_comment_params)
    @comment.facility_id = @facility.id
    @comment.save!
    redirect_to request.referer
  end

  def destroy
    @facility = Facility.find(params[:facility_id])
    comment = FacilityComment.find_by(id: params[:id], facility_id: params[:facility_id])
    comment.destroy
    redirect_to request.referer
  end

  private

  def facility_comment_params
    params.require(:facility_comment).permit(:comment, :rate)
  end
end
