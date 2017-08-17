class ShortUrlsController < ApplicationController

  def index
  end

  def create
    respond_to do |format|
      format.js
    end
  end

  private

  def allowed_params
    params.require(:short_url).permit(:original_url)
  end

end
