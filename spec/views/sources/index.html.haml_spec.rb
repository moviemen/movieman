require 'rails_helper'

RSpec.describe "sources/index", :type => :view do
  before(:each) do
    assign(:sources, [
      Source.create!(
        :link => "Link",
        :season => 1,
        :eposode => 2,
        :media_id => 3
      ),
      Source.create!(
        :link => "Link",
        :season => 1,
        :eposode => 2,
        :media_id => 3
      )
    ])
  end

  it "renders a list of sources" do
    render
    assert_select "tr>td", :text => "Link".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
