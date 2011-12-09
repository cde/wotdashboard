require 'spec_helper'

describe "reports/new.html.haml" do
  before(:each) do
    assign(:report, stub_model(Report,
      :title => "MyString",
      :note => "MyText",
      :filename => "MyString"
    ).as_new_record)
  end

  it "renders new report form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reports_path, :method => "post" do
      assert_select "input#report_title", :name => "report[title]"
      assert_select "textarea#report_note", :name => "report[note]"
      assert_select "input#report_filename", :name => "report[filename]"
    end
  end
end
