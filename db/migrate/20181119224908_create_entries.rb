class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.datetime :last_entry_date
      t.timestamps
    end
  end
end
