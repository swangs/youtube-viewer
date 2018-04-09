require 'google/apis/youtube_v3'
require 'google/api_client/client_secrets'

class HomeController < ApplicationController
  layout false

  def new_service
    secrets = Google::APIClient::ClientSecrets.new(
      {
        "web" =>
          {
            "access_token" => current_user.token,
            "refresh_token" => current_user.refresh_token,
            "client_id" => ENV["GOOGLE_CLIENT_ID"],
            "client_secret" => ENV["GOOGLE_CLIENT_SECRET"]
          }
      }
    )
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.client_options.application_name = 'Youtube Viewer'
    service.authorization = secrets.to_authorization
    service
  end

  def index
    if current_user
      response = new_service.list_searches(
        'snippet',
        event_type: 'live',
        max_results: 25,
        order: 'viewCount',
        type: 'video').to_json;
      response = JSON.parse(response);
      @top_streams = [];
      response['items'].each do |item|
        current_item = {};
        current_item['videoId'] = item['id']['videoId']
        current_item['title'] = item['snippet']['title']
        current_item['thumbnail'] =item['snippet']['thumbnails']['medium']['url']
        @top_streams << current_item
      end
    end
  end

  def show
    flash[:video_id] = params[:video_id]

    video_details = new_service.list_videos(
      'snippet, liveStreamingDetails',
      id: params[:video_id]).to_json
    video_details = JSON.parse(video_details)
    Video.set(video_details['items'][0])

    redirect_to root_path
  end
end
