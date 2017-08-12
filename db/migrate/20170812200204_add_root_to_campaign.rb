class AddRootToCampaign < ActiveRecord::Migration[5.1]
  def change
    add_column :campaigns, :root, :boolean, default: false
  end
end
