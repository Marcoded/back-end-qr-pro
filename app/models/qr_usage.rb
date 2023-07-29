class QrUsage < ApplicationRecord
    


FREE_LIMIT = 10

  def self.can_create_qr?(clerk_user_id)
    number_of_active_qrs = QrCode.where(clerk_user_id: clerk_user_id).count
    number_of_active_qrs < FREE_LIMIT
  end




end
