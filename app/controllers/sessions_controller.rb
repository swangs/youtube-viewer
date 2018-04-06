class SessionsController < ApplicationController

  def create
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      @hash = request.env['omniauth.auth'].to_json
      # flash[:success] = request.env['omniauth.auth']
    rescue
      flash[:warning] = "There was an error while trying to authenticate you..."
    end
    redirect_to root_path
    # render 'home/index'
  end

  def destroy
    if current_user
      session.delete(:user_id)
    end
    redirect_to root_path
  end
end
