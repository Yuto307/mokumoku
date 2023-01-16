class AddOnlyWomanToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :only_women, :boolean, default: false, null: false
  end
end
