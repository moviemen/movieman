require 'rails_helper'

RSpec.describe "media/show", :type => :view do
  before(:each) do
    @media = assign(:media, Media.create!(
      :type => "Type",
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/Name/)
  end
end
