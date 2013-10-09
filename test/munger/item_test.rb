require "test_helper"

describe Remunger::Item do
  include RemungerSpecHelper

  before(:all) do
    @data = Remunger::Data.new(:data => test_data)
  end

  it "must accept a hash with symbols" do
    hash = {'key1' => 'value1', 'key2' => 'value2'}
    item = Remunger::Item.ensure(hash)
    item.key1.must_equal('value1')
  end

  it "must accept a hash with strings" do
    hash = {:key1 => 'value1', :key2 => 'value2'}
    item = Remunger::Item.ensure(hash)
    item.key1.must_equal('value1')
    item.key2.wont_equal('value1')
    item.key3.must_equal(nil)
  end

  it "must accept mixed types" do
    hash = {:key1 => 'value1', 'key2' => 'value2'}
    item = Remunger::Item.ensure(hash)
    item.key1.must_equal('value1')
    item.key2.must_equal('value2')
  end

  it "must be able to access hash values indifferently" do
    hash = {:key1 => 'value1', 'key2' => 'value2'}
    item = Remunger::Item.ensure(hash)
    item['key1'].must_equal('value1')
    item[:key2].must_equal('value2')
  end

  it "must return a hash after being initialized with a hash" do
    hash = {:key1 => "value1", :key2 => "value2"}
    Remunger::Item.ensure(hash).to_hash.must_be_kind_of(Hash)
  end

end
