class Message < ApplicationRecord
  belongs_to :video,
  primary_key: :chat_id,
  foreign_key: :chat_id,
  class_name: :Video

  def self.add(messages)
    messages.each do |message|
      current_message = find_or_create_by(message_id: message['id'])
      current_message.author = message['authorDetails']['displayName']
      current_message.author_image = message['authorDetails']['profileImageUrl']
      current_message.body = message['snippet']['displayMessage']
      current_message.chat_id = message['snippet']['liveChatId']
      current_message.save!
      current_message
    end
  end
end
