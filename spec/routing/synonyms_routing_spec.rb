require "rails_helper"

RSpec.describe SynonymsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/synonyms").to route_to("synonyms#index")
    end

    it "routes to #new" do
      expect(:get => "/synonyms/new").to route_to("synonyms#new")
    end

    it "routes to #show" do
      expect(:get => "/synonyms/1").to route_to("synonyms#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/synonyms/1/edit").to route_to("synonyms#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/synonyms").to route_to("synonyms#create")
    end

    it "routes to #update" do
      expect(:put => "/synonyms/1").to route_to("synonyms#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/synonyms/1").to route_to("synonyms#destroy", :id => "1")
    end

  end
end
