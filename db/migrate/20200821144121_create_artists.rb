class CreateArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :hot_100_hits

      t.timestamps
    end
  end
end
