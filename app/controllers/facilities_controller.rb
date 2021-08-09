class FacilitiesController < ApplicationController

  def index
    @facilities = Facility.all
    @reserve_facilities = ReserveFacility.all
  end

  def show
    @facility           = Facility.find(params[:id])
    @comment            = FacilityComment.new
    @facility_comments  = @facility.facility_comments
    @reserve_facility   = ReserveFacility.new
    @reserve_facilities = ReserveFacility.where(facility_id: @facility.id)

    # googelmap.jsで使用する変数
    lat = @facility.facility_place.latitude
    lng = @facility.facility_place.longitude
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
    @facility = Facility.new(facility_params)
    @facility.admin_id = current_admin.id
    if @facility.save!
      redirect_to root_path
    else
      redirect_to new_post_path
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
