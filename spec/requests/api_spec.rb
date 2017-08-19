require 'rails_helper'

RSpec.describe "Api", type: :request do
  
  describe "GET /api/v1/short_urls/:id" do
    
    context "when ShortUrl exist" do

      it "returns ShortUrl hash string data" do
        url = create(:short_url)

        get api_v1_short_url_path(url.url)

        expect(response).to have_http_status(200)

        parsed_body = JSON.parse(response.body)

        expect(parsed_body['id']).to eq(url.id)
      end

    end

    context "when ShortUrl does not exist" do

      it "responds with error" do
        get api_v1_short_url_path("nonexistent")

        expect(response).to have_http_status(404)

        parsed_body = JSON.parse(response.body)

        expect(parsed_body).to include("errors")
        expect(parsed_body['errors']).to eq("ShortUrl not found.")
      end

    end

  end

  describe "POST /api/v1/short_urls" do

    context "when :original_url param is valid" do

      it "creates a ShortUrl" do
        original_url = Faker::Internet.url
        
        post api_v1_short_urls_path, params: { url: original_url }

        expect(response).to have_http_status(201)
        expect(ShortUrl.count).to eq(1)

        parsed_body = JSON.parse(response.body)

        expect(parsed_body['original_url']).to eq(original_url)
      end

    end

    context "when :original_url param is invalid" do

      it "returns an error" do
        post api_v1_short_urls_path, params: { url: "http:/invalid.com" }

        expect(response).to have_http_status(422)
        expect(ShortUrl.count).to eq(0)

        parsed_body = JSON.parse(response.body)
        
        expect(parsed_body).to include("errors")
        expect(parsed_body["errors"]).to include("Original url is invalid")
      end

    end

    context "when :original_url param is blank" do

      it "returns an error" do
        post api_v1_short_urls_path, params: { url: "" }

        expect(response).to have_http_status(422)
        expect(ShortUrl.count).to eq(0)

        parsed_body = JSON.parse(response.body)

        expect(parsed_body).to include("errors")
        expect(parsed_body["errors"]).to include("Original url is invalid")
        expect(parsed_body["errors"]).to include("Original url can't be blank")
      end

    end

  end

end
