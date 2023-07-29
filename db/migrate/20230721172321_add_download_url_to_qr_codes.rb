class AddDownloadUrlToQrCodes < ActiveRecord::Migration[7.0]
  def change
    add_column :qr_codes, :download_url, :string
  end
end
