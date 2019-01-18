class CreateHeros < ActiveRecord::Migration
  def change
    create_table :heros do |t|
      t.string :name
      t.string :battle_cry
      t.integer :user_id
    end
  end
end
