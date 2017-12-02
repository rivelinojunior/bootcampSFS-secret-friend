class ChangeTypeStatusToCampaign < ActiveRecord::Migration[5.0]
  def change
    change_column :campaigns, :status, :string
  end
end
