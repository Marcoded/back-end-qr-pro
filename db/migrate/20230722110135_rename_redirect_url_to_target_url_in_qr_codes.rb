class RenameRedirectUrlToTargetUrlInQrCodes < ActiveRecord::Migration[7.0]
  def change
    rename_column :qr_codes, :redirect_url, :target_url
  end
end
