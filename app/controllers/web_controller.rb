class WebController < ApplicationController
  before_action :set_notifications

  def set_notifications
    @notifications = []
  end

  def current_profile
    current_user && current_user.profile
  end
end
