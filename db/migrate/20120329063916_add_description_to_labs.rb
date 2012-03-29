class AddDescriptionToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :Description, :text
  end
end
