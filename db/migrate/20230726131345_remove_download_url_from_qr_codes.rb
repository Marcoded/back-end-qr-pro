class RemoveDownloadUrlFromQrCodes < ActiveRecord::Migration[7.0]
  def change
    remove_column :qr_codes, :download_url, :string
  end
end
