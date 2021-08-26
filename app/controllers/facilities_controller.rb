class FacilitiesController < ApplicationController

  def index
    @facilities         = Facility.all
    @reserve_facilities = ReserveFacility.all

    if params[:north]
      lat = Range.new(*[params["north"], params["south"]].sort)
      lon = Range.new(*[params["east"], params["west"]].sort)
      # データ取得
      @reserve_facilities = ReserveFacility.facility_places.where(latitude: lat, longitude: lon)
      @facilities         = a
    end
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @facility           = Facility.find(params[:id])

    # コメントに関する変数
    @comment            = FacilityComment.new
    @facility_comments  = @facility.facility_comments.order(created_at: :DESC)

    # 施設予約に関する変数
    @reserve_facility   = ReserveFacility.new
    @reserve_facilities = ReserveFacility.where(facility_id: @facility.id)

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
