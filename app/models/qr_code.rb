require "rqrcode"
require "securerandom"

class QrCode < ApplicationRecord
  before_create :generate_unique_url, :generate_qr_code_data
  after_update :generate_qr_code_data
  #after_create :set_dummy_link

  private

  def generate_unique_url
    random_number = SecureRandom.uuid
    server_address = Rails.env.production? ? "https://your-production-url.com" : "http://localhost:3000"
    self.random_server_url = "#{server_address}/api/v1/redirect/#{random_number}"
    puts "Generated URL is: #{random_server_url}"
  end

  def generate_qr_code_data
    qrcode = RQRCode::QRCode.new(random_server_url, level: :m)
    puts "generating qr code with a color of " + self.main_color
    self.main_color = self.main_color.delete("#")
    self.qr_code_data  = qrcode.as_svg(
      offset: 50,
      color: self.main_color,
      shape_rendering: "crispEdges",
      module_size: 6,
      standalone: true,
      use_path: true
    )
  end

  def set_dummy_link
    self.target_url = "https://media.tenor.com/V0PyK4xovxAAAAAC/peepo-dance-pepe.gif"
  end

  # Uncomment this method if needed in the future
  # def download_url
  #   "#{server_address}/qr_codes/#{id}/download_svg"
  # end
end
