class CreateVideoCalls < ActiveRecord::Migration[5.2]
  def change
    create_table :video_calls do |t|
      t.string :link
      t.string :string

      t.timestamps
    end
  end
end
