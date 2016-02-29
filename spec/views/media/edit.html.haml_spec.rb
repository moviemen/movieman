require 'rails_helper'

RSpec.describe "media/edit", :type => :view do
  before(:each) do
    @media = assign(:media, Media.create!(
      :type => "",
      :name => "MyString"
    ))
  end

  it "renders the edit media form" do
    render

    assert_select "form[action=?][method=?]", media_path(@media), "post" do

      assert_select "input#media_type[name=?]", "media[type]"

      assert_select "input#media_name[name=?]", "media[name]"
    end
  end
end
