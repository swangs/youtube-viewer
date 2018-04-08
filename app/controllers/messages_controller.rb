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
end
