class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.boolean :is_admin
      t.string :activation_digest
      t.boolean :activated
      t.string :reset_digest

      t.timestamps null: false
    end
  end
end
