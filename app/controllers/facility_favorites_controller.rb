class FacilityFavoritesController < ApplicationController

  def index
    north       = params[:north]
    south       = params[:south]
    east        = params[:east]
    west        = params[:west]
    @user       = User.find(params[:user_id])
    @facilities = @user.facility_favorites

    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @facility = Facility.find(params[:facility_id])
    favorite  = current_user.facility_favorites.new(facility_id: @facility.id)
    favorite.save
  end

  def destroy
    @facility = Facility.find(params[:facility_id])
    favorite  =  current_user.facility_favorites.find_by(facility_id: @facility.id)
    favorite.destroy
  end
end
