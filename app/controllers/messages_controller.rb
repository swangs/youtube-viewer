require 'google/apis/youtube_v3'
require 'google/api_client/client_secrets'

class MessagesController < ApplicationController
  def index
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


    messages = service.list_live_chat_messages(
      params[:chat_id],
      'snippet, authorDetails',
      page_token: params[:nextPageToken]).to_json

    messages = JSON.parse(messages)
    Message.add(messages['items'])

    render json: messages, status: 200
  end

  def search
    if params[:query].length < 3
      render json: ["Please search with at least 3 characters"], status: 400
    else
      stream = Video.find_by(video_id: params[:video_id])
      searchResults = stream.messages.where("REPLACE(LOWER(author), ' ', '') LIKE ?", "%#{params[:query]}%")

      if searchResults.length > 1
        render json: searchResults, status: 200
      else
        render json: ["No matches found"], status: 404
      end
    end
  end
end
