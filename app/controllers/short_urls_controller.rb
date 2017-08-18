class ShortUrlsController < ApplicationController

  def index
  end

  def show
    @url = ShortUrl.find_by(url: params[:id].to_s)

    if @url.present?
      @url.update_stats(request)
    end
  end

end
