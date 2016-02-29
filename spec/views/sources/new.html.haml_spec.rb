require 'rails_helper'

RSpec.describe "sources/new", :type => :view do
  before(:each) do
    assign(:source, Source.new(
      :link => "MyString",
      :season => 1,
      :eposode => 1,
      :media_id => 1
    ))
  end

  it "renders new source form" do
    render

    assert_select "form[action=?][method=?]", sources_path, "post" do

      assert_select "input#source_link[name=?]", "source[link]"

      assert_select "input#source_season[name=?]", "source[season]"

      assert_select "input#source_eposode[name=?]", "source[eposode]"

      assert_select "input#source_media_id[name=?]", "source[media_id]"
    end
  end
end
