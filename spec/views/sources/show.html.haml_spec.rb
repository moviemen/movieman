require 'rails_helper'

RSpec.describe "sources/show", :type => :view do
  before(:each) do
    @source = assign(:source, Source.create!(
      :link => "Link",
      :season => 1,
      :eposode => 2,
      :media_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Link/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
