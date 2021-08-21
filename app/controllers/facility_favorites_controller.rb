class FacilityFavoritesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @facilities = @user.facility_favorites
  end

  def create
    @facility = Facility.find(params[:facility_id])
    favorite = current_user.facility_favorites.new(facility_id: @facility.id)
    favorite.save!
    redirect_to request.referer
  end

  def destroy
    @facility = Facility.find(params[:facility_id])
    favorite =  current_user.facility_favorites.find_by(facility_id: @facility.id)
    favorite.destroy
    redirect_to request.referer
  end
end
