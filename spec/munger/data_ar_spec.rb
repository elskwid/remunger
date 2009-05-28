require File.dirname(__FILE__) + "/../spec_helper"

describe Munger::Data do 
  include MungerSpecHelper
  
  before(:each) do 
    @data = Munger::Data.new(:data => test_ar_data)
  end

  it "should accept an AR dataset" do
    Munger::Data.new(:data => test_ar_data).should be_valid
  end
  
  it "should be able to set AR data after init" do
    m = Munger::Data.new
    m.data = test_ar_data
    m.should be_valid
  end
  
  it "should be able to set AR data in init block" do
    m = Munger::Data.new do |d|
      d.data = test_ar_data
    end
    m.should be_valid
  end
  # 
  it "should be able to add more data after init" do
    m = Munger::Data.new
    m.data = test_ar_data
    m.add_data more_test_data
    m.should be_valid
    additional_names = m.data.select { |r| r[:name] == 'David' || r[:name] == 'Michael' }
    additional_names.should have(4).items
  end
end