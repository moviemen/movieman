require 'rails_helper'

RSpec.describe "synonyms/new", :type => :view do
  before(:each) do
    assign(:synonym, Synonym.new(
      :name => "MyString",
      :media_id => 1
    ))
  end

  it "renders new synonym form" do
    render

    assert_select "form[action=?][method=?]", synonyms_path, "post" do

      assert_select "input#synonym_name[name=?]", "synonym[name]"

      assert_select "input#synonym_media_id[name=?]", "synonym[media_id]"
    end
  end
end
