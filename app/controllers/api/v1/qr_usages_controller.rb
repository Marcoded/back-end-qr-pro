class Api::V1::QrUsagesController < ApplicationController

  def check_usage
    number_of_active_qrs = QrCode.where(clerk_user_id: clerk_user['id']).count
    can_create = number_of_active_qrs < QrUsage::FREE_LIMIT
    qr_left = QrUsage::FREE_LIMIT - number_of_active_qrs
    render json: {activeQr: number_of_active_qrs, limit: QrUsage::FREE_LIMIT,QrLeft:qr_left ,canCreate: can_create }
  end



  private
   def authorize_request
    return render json: { message: "You are not authorized" }, status: :unauthorized unless clerk_session.present?
  end
end
