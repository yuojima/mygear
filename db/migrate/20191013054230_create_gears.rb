class CreateGears < ActiveRecord::Migration[5.2]
  def change
    create_table :gears do |t|
      t.string :code
      t.string :name
      t.string :url
      t.string :image_url

      t.timestamps
    end
  end
end
