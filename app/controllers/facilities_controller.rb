class FacilitiesController < ApplicationController
  before_action :move_to_newpage, only:[:show]

  # 施設詳細ページで施設投稿していない場合は投稿ページに遷移
  def move_to_newpage
    if admin_signed_in?
      myfacility = Facility.find_by(admin_id: current_admin.id)
      if myfacility == nil
        redirect_to new_facility_path
        flash[:notice] = "まずは新規登録をしてください"
      end
    end
  end

  def index
    # 表示されているMapの範囲を取得する
    north = params[:north]
    south = params[:south]
    east  = params[:east]
    west  = params[:west]

    # 表示されているMapの範囲にある施設を取得
    @facilities = FacilityPlace.where( latitude: south..north, longitude: west..east )

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @facility           = Facility.find(params[:id])

    # コメントに関する変数
    @comment            = FacilityComment.new
    @facility_comments  = @facility.facility_comments

    # 施設予約に関する変数
    @reserve_facility   = ReserveFacility.new
    @reserve_facilities = ReserveFacility.where(facility_id: @facility.id)

    # 施設にコメンがある場合はグラフデータを取得する
    if @facility_comments.present?
      @graph = FacilityComment.rate_persent(@facility_comments)
    end
    # googelmap.jsで使用する変数
    lat     = @facility.facility_place.latitude
    lng     = @facility.facility_place.longitude
    gon.lat = lat
    gon.lng = lng

    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @facility = Facility.new
    @facility.build_facility_place
  end

  def create
    @facility          = Facility.new(facility_params)
    @facility.admin_id = current_admin.id
    if @facility.save
      redirect_to facility_path(@facility)
    else
      render new_facility_path
    end
  end

  def update
    @facility       = Facility.find(params[:id])
    @reserve_permit = @facility.reserve_facilities
  end


  private

    def facility_params
      params.require(:facility).permit(:name,
                                       :opening,
                                       :closing,
                                       :station,
                                       :parking,
                                       :postcode,
                                       :address,
                                       :phone_number,
                                       :email,
                                       :facility_image,
                                       :comment,
                                       facility_place_attributes: [:address]
                                      )
    end
end
