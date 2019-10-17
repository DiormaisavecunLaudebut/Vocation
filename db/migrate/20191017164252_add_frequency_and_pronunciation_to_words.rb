class AddFrequencyAndPronunciationToWords < ActiveRecord::Migration[5.2]
  def change
    add_column :words, :frequency, :integer
    add_column :words, :pronunciation, :string
  end
end
