class CreateDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :details do |t|
      t.string :definition
      t.string :synonyms, array: true
      t.string :nature
      t.string :examples, array: true
      t.string :antonyms, array: true
      t.references :word, foreign_key: true

      t.timestamps
    end
  end
end
