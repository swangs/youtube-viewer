class Video < ApplicationRecord
  has_many :messages,
  primary_key: :chat_id,
  foreign_key: :chat_id,
  class_name: :Message

  def self.set(response)
    video = find_or_create_by(video_id: response['id'])
    video.title = response['snippet']['title']
    video.concurrent_viewers = response['liveStreamingDetails']['concurrentViewers']
    video.chat_id = response['liveStreamingDetails']['activeLiveChatId']
    video.save!
    video
  end
end
