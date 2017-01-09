class LinksController < ApplicationController
  def index
    @hot_links = Link.hot
    @user_links = current_user.links if logged_in?
  end
end
