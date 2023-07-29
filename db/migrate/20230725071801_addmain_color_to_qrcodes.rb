class AddmainColorToQrcodes < ActiveRecord::Migration[7.0]
  def change
    add_column :qr_codes, :main_color, :string
  end
end
