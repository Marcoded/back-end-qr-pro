class CreateQrUsages < ActiveRecord::Migration[7.0]
  def change
    create_table :qr_usages do |t|

      t.timestamps
    end
  end
end
