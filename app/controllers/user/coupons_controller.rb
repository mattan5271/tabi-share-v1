class User::CouponsController < ApplicationController
  before_action :authenticate_user!

  def index
    @coupons = Coupon.where(user_id: current_user.id).where(is_valid: '有効').page(params[:page]).per(20)
  end
end
