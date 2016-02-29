require 'rails_helper'

RSpec.describe "media/new", :type => :view do
  before(:each) do
    assign(:media, Media.new(
      :type => "",
      :name => "MyString"
    ))
  end

  it "renders new media form" do
    render

    assert_select "form[action=?][method=?]", media_index_path, "post" do

      assert_select "input#media_type[name=?]", "media[type]"

      assert_select "input#media_name[name=?]", "media[name]"
    end
  end
end
