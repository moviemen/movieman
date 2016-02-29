require 'rails_helper'

RSpec.describe "synonyms/show", :type => :view do
  before(:each) do
    @synonym = assign(:synonym, Synonym.create!(
      :name => "Name",
      :media_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/1/)
  end
end
