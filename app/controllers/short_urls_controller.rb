class ShortUrlsController < ApplicationController

  def index
  end

  def show
    @url = ShortUrl.find_by(slug: params[:id].to_s)
  end

end
