class CreateQrCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :qr_codes do |t|

      t.timestamps
      t.string :title
      t.string :redirect_url
      t.string :random_server_url
      t.string :qr_code_data
      t.string :clerk_user_id
    end
  end
end
