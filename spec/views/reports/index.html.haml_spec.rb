require 'spec_helper'

describe "reports/index.html.haml" do
  before(:each) do
    assign(:reports, [
      stub_model(Report,
        :title => "Title",
        :note => "MyText",
        :filename => "Filename"
      ),
      stub_model(Report,
        :title => "Title",
        :note => "MyText",
        :filename => "Filename"
      )
    ])
  end

  it "renders a list of reports" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Filename".to_s, :count => 2
  end
end
