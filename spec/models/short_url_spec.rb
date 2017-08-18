require 'rails_helper'

RSpec.describe ShortUrl, type: :model do

  it "validates :original_url presence" do
    expect(create(:short_url)).to be_valid

    blank_url = build(:short_url, original_url: "")

    expect(blank_url.save).to be false
  end

  it "validates :original_url format" do
    expect(create(:short_url)).to be_valid

    invalid_url1 = build(:short_url, original_url: "http:/invalid.com")
    invalid_url2 = build(:short_url, original_url: "googledotcom")
    
    expect(invalid_url1.save).to be false
    expect(invalid_url2.save).to be false
  end

  it "checks if :original_url has protocol before validation on create" do
    url1 = create(:short_url, original_url: "http://withhttp.com")
    url2 = create(:short_url, original_url: "withouthttp.com")

    expect(url1.original_url).to eq("http://withhttp.com")
    expect(url2.original_url).to eq("http://withouthttp.com")
  end

  it "sets short_url after create" do
    url = create(:short_url)

    expect(url.url).not_to be_empty
    expect(url.url).not_to be_nil
  end

end