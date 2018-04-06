class User < ApplicationRecord
  def self.from_omniauth(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.name = auth_hash['info']['name']
    user.first_name = auth_hash['info']['first_name']
    user.last_name = auth_hash['info']['last_name']
    user.image_url = auth_hash['info']['image']
    user.url = auth_hash['info']['urls']['google']
    user.token = auth_hash['credentials']['token']
    user.refresh_token = auth_hash['credentials']['refresh_token']
    user.save!
    user
  end
end
