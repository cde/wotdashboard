require 'spec_helper'

describe Graphic do

  before {@graphic = Graphic.new}

  subject{@graphic}

  context "when title empty" do
    it {should_not be_valid}
    specify {@graphic.save.should be_false}
  end


  it { should validate_presence_of :title }
  it { should validate_presence_of :chart_type }
end


