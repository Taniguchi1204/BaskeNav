class ReserveFacilitiesController < ApplicationController

  def create
    @facility                     = Facility.find(params[:facility_id])
    @reserve_facility             = current_user.reserve_facilities.new(reserve_facility_params)
    @reserve_facility.facility_id = @facility.id
    
    # 非同期通信で使用するインスタンス変数
    @comment                      = FacilityComment.new
    @facility_comments            = @facility.facility_comments

    # 施設にコメンがある場合はグラフデータを取得する(非同期用)
    if @facility_comments.present?
      @graph = FacilityComment.rate_persent(@facility_comments)
    end
    
    # googelmap.jsで使用する変数
    lat     = @facility.facility_place.latitude
    lng     = @facility.facility_place.longitude
    gon.lat = lat
    gon.lng = lng

    if @reserve_facility.save
     redirect_to request.referer
    else
      render "facilities/show"
    end
  end

  def update
    @facility                  = Facility.find(params[:facility_id])
    @reserve_permit            = @facility.reserve_facilities.find(params[:id])
    
    # 予約を管理者側で承認可否を更新
    if @reserve_permit.confirm == false
     @reserve_permit.update(confirm: "true")
    else
      @reserve_permit.update(confirm: "false")
    end
     redirect_to request.referer
  end

  def destroy
    facility          = Facility.find(params[:facility_id])
    @reserve_facility = facility.reserve_facilities.find(params[:id])
    @reserve_facility.destroy
    redirect_to request.referer
  end

  private

  def reserve_facility_params
    params.require(:reserve_facility).permit(:start, :finish, :number, :date, :comment, :with_friend)
  end
end
