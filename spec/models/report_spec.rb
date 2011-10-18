require 'spec_helper'

describe Report do

  before { @report = Report.new }

  subject { @report }

  context "when dates empty" do
    it { should_not be_valid }
    specify { @report.save.should == false }
  end

  context "when chart type is nil" do
    it { should_not be_valid }
    specify { @report.save.should == false }
  end

end
