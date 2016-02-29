require 'rails_helper'

RSpec.describe "synonyms/index", :type => :view do
  before(:each) do
    assign(:synonyms, [
      Synonym.create!(
        :name => "Name",
        :media_id => 1
      ),
      Synonym.create!(
        :name => "Name",
        :media_id => 1
      )
    ])
  end

  it "renders a list of synonyms" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
