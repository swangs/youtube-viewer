class Video < ApplicationRecord
  def self.set(response)
    video = find_or_create_by(video_id: response['items'][0]['id'])
    video.title = response['items'][0]['snippet']['title']
    video.concurrent_viewers = response['items'][0]['liveStreamingDetails']['concurrentViewers']
    video.chat_id = response['items'][0]['liveStreamingDetails']['activeLiveChatId']
    video.save!
    video
  end
end
