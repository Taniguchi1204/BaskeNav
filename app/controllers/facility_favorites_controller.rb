class FacilityFavoritesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @facilities = @user.facility_favorites
  end

  def create
    @facility = Facility.find(params[:facility_id])
    favorite = current_user.facility_favorites.new(facility_id: @facility.id)
    favorite.save
  end

  def destroy
    @facility = Facility.find(params[:facility_id])
    favorite =  current_user.facility_favorites.find_by(facility_id: @facility.id)
    favorite.destroy
  end
end
