class ReserveFacilitiesController < ApplicationController

  def create
    facility = Facility.find(params[:facility_id])
    @reserve_facility = current_user.reserve_facilities.new(reserve_facility_params)
    @reserve_facility.facility_id = facility.id
    @reserve_facility.save
    redirect_to request.referer
  end

  private

  def reserve_facility_params
    params.require(:reserve_facility).permit(:start, :finish, :number)
  end
end
