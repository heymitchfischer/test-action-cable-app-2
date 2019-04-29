class ApplicationController < ActionController::Base
  before_action :authenticate_user!, only: [:get_current_user]

  def get_current_user
    render json: {current_user_id: current_user.id}
  end
end
