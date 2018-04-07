class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :video_id
      t.string :title
      t.string :concurrent_viewers
      t.string :chat_id

      t.timestamps
    end
  end
end
