require 'spec_helper'

describe "reports/edit.html.haml" do
  before(:each) do
    @report = assign(:report, stub_model(Report,
      :title => "MyString",
      :note => "MyText",
      :filename => "MyString"
    ))
  end

  it "renders the edit report form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reports_path(@report), :method => "post" do
      assert_select "input#report_title", :name => "report[title]"
      assert_select "textarea#report_note", :name => "report[note]"
      assert_select "input#report_filename", :name => "report[filename]"
    end
  end
end
