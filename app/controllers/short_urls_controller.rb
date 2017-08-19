class ShortUrlsController < ApplicationController

  def index
  end

  def show
    @url = ShortUrl.find_by(url: params[:id].to_s)

    if @url.present?
      @url.update_stats(request)

      redirect_to @url.original_url
    else
      render :show
    end
  end

  def stats

  end

end
