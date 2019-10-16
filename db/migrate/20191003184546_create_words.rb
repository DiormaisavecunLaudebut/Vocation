class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.string :entry
      t.string :translation, array: true

      t.timestamps
    end
  end
end
