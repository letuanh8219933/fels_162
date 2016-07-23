class RemoveNativeWordFromWords < ActiveRecord::Migration
  def change
    remove_column :words, :native_word, :string
  end
end
