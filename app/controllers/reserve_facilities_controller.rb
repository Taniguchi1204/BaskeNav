class ReserveFacilitiesController < ApplicationController

  def create
    @facility = Facility.find(params[:facility_id])
    @comment            = FacilityComment.new
    @facility_comments  = @facility.facility_comments
    # 評価グラフを表示するデータ
    if @facility_comments.present?
      @data = [['5', FacilityComment.rate_persent(5, @facility_comments)],
               ['4', FacilityComment.rate_persent(4, @facility_comments)],
               ['3', FacilityComment.rate_persent(3, @facility_comments)],
               ['2', FacilityComment.rate_persent(2, @facility_comments)],
               ['1', FacilityComment.rate_persent(1, @facility_comments)],
              ]
    end
    # googelmap.jsで使用する変数
    lat     = @facility.facility_place.latitude
    lng     = @facility.facility_place.longitude
    gon.lat = lat
    gon.lng = lng

    @reserve_facilities = ReserveFacility.where(facility_id: @facility.id)
    @reserve_facility = current_user.reserve_facilities.new(reserve_facility_params)
    @reserve_facility.facility_id = @facility.id
    if @reserve_facility.save
      redirect_to request.referer
    else
      render "facilities/show"
    end
    respond_to do |format|
      format.html
      format.json
    end
  end

  def update
    @facility = Facility.find(params[:facility_id])
    @reserve_permit = @facility.reserve_facilities.find(params[:id])
    if @reserve_permit.confirm == false
     @reserve_permit.update(confirm: "true")
    else
      @reserve_permit.update(confirm: "false")
    end
    redirect_to request.referer
  end

  def destroy
    facility = Facility.find(params[:facility_id])
    @reserve_facility = facility.reserve_facilities.find(params[:id])
    @reserve_facility.destroy
    redirect_to request.referer
  end

  private

  def reserve_facility_params
    params.require(:reserve_facility).permit(:start, :finish, :number, :date, :comment, :with_friend)
  end
end
