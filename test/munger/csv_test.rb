require "test_helper"

describe Remunger::Render::CSV do
  include RemungerSpecHelper

  before(:each) do
    @data = Remunger::Data.new(:data => test_data + [{:name => 'Comma, Guy', :age => 100, :day => 0, :score => 0}])
    @report = Remunger::Report.new(:data => @data)
  end

  it "should accept a Remunger::Report object" do
    Remunger::Render::Text.new(@report.process).must_be :valid?
  end

  it "should render a basic text table" do
    @render = Remunger::Render::CSV.new(@report.process)
    count = @report.rows
    text = @render.render
    text.split("\n").size.must_be :>, count
  end

  it "should quote data with commas" do
    @render = Remunger::Render::CSV.new(@report.process)
    text = @render.render
    text.must_match /"Comma, Guy"/
  end
end
