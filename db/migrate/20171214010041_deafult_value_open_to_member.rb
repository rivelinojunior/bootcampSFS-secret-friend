class DeafultValueOpenToMember < ActiveRecord::Migration[5.0]
  def change
    change_column :members, :open, :boolean, default: false
  end
end
