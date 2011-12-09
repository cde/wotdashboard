require 'spec_helper'

describe "reports/show.html.haml" do
  before(:each) do
    @report = assign(:report, stub_model(Report,
      :title => "Title",
      :note => "MyText",
      :filename => "Filename"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Filename/)
  end
end
