class RemoveIndexFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :index, :string
    remove_column :posts, :show, :string
  end
end
