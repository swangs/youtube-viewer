class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :message_id
      t.string :author
      t.string :body
      t.string :chat_id

      t.timestamps
    end
  end
end
