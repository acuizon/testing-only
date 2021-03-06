class Api::V1::ShortUrlsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    url = ShortUrl.new(original_url: params[:url])
    
    if url.save
      render json: url, status: 201
    else
      render json: { errors: url.errors.full_messages }, status: 422
    end
  end

  def show
    url = ShortUrl.find_by(url: params[:id])

    if url.present?
      render json: url, status: 200
    else
      render json: { errors: "ShortUrl not found." }, status: 404
    end
  end

  def stats
    url = ShortUrl.find_by(url: params[:id])

    if url.present?
      res = url.stats(params[:start_range].presence, params[:end_range].presence)

      render json: res, status: res.keys.include?(:errors) ? 404 : 200
    else
      render json: { errors: "ShortUrl not found." }, status: 404
    end
  end

end
