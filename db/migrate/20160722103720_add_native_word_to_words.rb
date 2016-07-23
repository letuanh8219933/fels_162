class AddNativeWordToWords < ActiveRecord::Migration
  def change
    add_column :words, :native_word, :string
  end
end
