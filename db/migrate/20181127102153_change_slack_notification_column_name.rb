class ChangeSlackNotificationColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :slack_notifications, :last_entry_date, :last_notification_date
  end
end
