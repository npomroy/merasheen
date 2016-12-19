class RemoveLinksFromLogs < ActiveRecord::Migration[5.0]
  def change
    remove_column :logs, :link, :string
  end
end
