class QrCode < ApplicationRecord
  require "rqrcode"
  require "securerandom"

  before_create :generate_unique_url
  after_commit :generate_qr_code_data, on: [:create, :update]
 
  private

  def generate_unique_url
    return if self.random_server_url?
    random_number = SecureRandom.uuid
    server_address = Rails.env.production? ? "https://back-end-qr-code.fly.dev" : "http://localhost:3000"
    self.random_server_url = "#{server_address}/api/v1/redirect/#{random_number}"
  end

  def generate_qr_code_data
    return puts "NO URL HERE YET" if self.random_server_url.nil?
    qrcode = RQRCode::QRCode.new(self.random_server_url, level: :m)
    self.qr_code_data = qrcode.as_svg(
      offset: 50,
      color: self.main_color.delete("#"),
      shape_rendering: "crispEdges",
      module_size: 6,
      standalone: true,
      use_path: true
    )
    self.save! if self.qr_code_data_changed?
  end
end