require "test_helper"

describe Remunger::Render do
  include RemungerSpecHelper

  before(:each) do
    @data = Remunger::Data.new(:data => test_data)
    @report = Remunger::Report.new(:data => @data).process
  end

  it "must render html" do
    html = Remunger::Render.to_html(@report)
    html.must_have_tag('table')
  end

  it "must render sortable html" do
    html = Remunger::Render.to_sortable_html(@report, :sort => "name", :order => "asc", :url => "test")
    html.must_have_tag("table")
    html.must_have_tag("th.unsorted")
    html.must_have_tag("th.sorted")
    html.must_have_tag("th.sorted-asc")
    html.must_have_tag("sort")
  end

  it "must render text" do
    text = Remunger::Render.to_text(@report)
    text.wont_have_tag('table')
    text.split("\n").length.must_be :>=, 5
  end

  it "must render xls"

  it "must render csv"

  it "must render pdf"

end
