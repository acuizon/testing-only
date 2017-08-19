require 'rails_helper'

RSpec.describe "App", type: :request do

  describe "GET /" do

    it "renders index page" do
      get root_path
      
      expect(response).to render_template(:index)
      expect(response).to have_http_status(200)
    end

  end

  describe "GET /:id" do

    context "when ShortUrl exist" do

      it "redirects to original_url" do
        url = create(:short_url)
        
        get "/#{url.url}"

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(url.original_url)
      end

    end

    context "when ShortUrl does not exist" do

      it "displays message" do
        get "/nonexistent"

        expect(response).to render_template(:show)
        expect(response.body).to include("Your shortened url doesn't exist. It has probably expired if you shortened before or it hasn't been shortened at all.")
      end

    end

  end

  describe "GET /short_urls/stats" do

    it "renders stats page" do
      get stats_short_urls_path

      expect(response).to render_template(:stats)
      expect(response).to have_http_status(200)
      expect(response.body).to include("Inquire stats for your Short Url")
    end

  end

end
