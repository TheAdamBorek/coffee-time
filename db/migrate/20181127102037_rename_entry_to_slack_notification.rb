class RenameEntryToSlackNotification < ActiveRecord::Migration[5.2]
  def change
    rename_table :entries, :slack_notifications
  end
end
