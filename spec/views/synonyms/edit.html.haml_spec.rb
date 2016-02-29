require 'rails_helper'

RSpec.describe "synonyms/edit", :type => :view do
  before(:each) do
    @synonym = assign(:synonym, Synonym.create!(
      :name => "MyString",
      :media_id => 1
    ))
  end

  it "renders the edit synonym form" do
    render

    assert_select "form[action=?][method=?]", synonym_path(@synonym), "post" do

      assert_select "input#synonym_name[name=?]", "synonym[name]"

      assert_select "input#synonym_media_id[name=?]", "synonym[media_id]"
    end
  end
end
