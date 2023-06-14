class WelcomeController < ApplicationController
  def index
    return unless logged_in?

    @article = current_user.articles.build
    @pagy, @feed_items = pagy current_user.feed.newest
  end
end
