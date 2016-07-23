class RemoveMeaningFromWords < ActiveRecord::Migration
  def change
    remove_column :words, :meaning, :string
  end
end
