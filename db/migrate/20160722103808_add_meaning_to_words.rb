class AddMeaningToWords < ActiveRecord::Migration
  def change
    add_column :words, :meaning, :string
  end
end
