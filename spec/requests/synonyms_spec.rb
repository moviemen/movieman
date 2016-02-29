require 'rails_helper'

RSpec.describe "Synonyms", :type => :request do
  describe "GET /synonyms" do
    it "works! (now write some real specs)" do
      get synonyms_path
      expect(response).to have_http_status(200)
    end
  end
end
