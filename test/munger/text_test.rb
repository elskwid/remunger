require "test_helper"

describe Remunger::Render::Text do
  include RemungerSpecHelper

  before(:each) do
    @data = Remunger::Data.new(:data => test_data)
    @report = Remunger::Report.new(:data => @data)
  end

  it "should accept a Remunger::Report object" do
    Remunger::Render::Text.new(@report.process).must_be :valid?
  end

  it "should render a basic text table" do
    @render = Remunger::Render::Text.new(@report.process)
    count = @report.rows
    text = @render.render
    text.split("\n").size.must_be :>, count
  end

end
