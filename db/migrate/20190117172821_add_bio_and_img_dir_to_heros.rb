class AddBioAndImgDirToHeros < ActiveRecord::Migration
  def change
    add_column :heros, :bio, :string
    add_column :heros, :img_path, :string
  end
end
