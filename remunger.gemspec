Gem::Specification.new do |s|
  s.platform  =  Gem::Platform::RUBY
  s.name      =  "remunger"
  s.version   =  "0.1.0"
  s.authors   =  ["Don Morrison"]
  s.email     =  "don@elskwid.net"
  s.summary   =  "A reporting engine in Ruby (formerly known as munger)."
  s.homepage  =  "http://github/elskwid/remunger"
  s.has_rdoc  =  true

  s.files = [
    "remunger.gemspec",
    "Rakefile",
    "README",
    "examples/column_add.rb",
    "examples/development.log",
    "examples/example_helper.rb",
    "examples/sinatra_app.rb",
    "examples/test.html",
    "lib/munger.rb",
    "lib/munger/data.rb",
    "lib/munger/item.rb",
    "lib/munger/render.rb",
    "lib/munger/report.rb",
    "lib/munger/render/csv.rb",
    "lib/munger/render/html.rb",
    "lib/munger/render/sortable_html.rb",
    "lib/munger/render/text.rb"]

  s.test_files = [
    "test/test_helper.rb",
    "test/munger/csv_test.rb",
    "test/munger/data_ar_test.rb",
    "test/munger/data_test.rb",
    "test/munger/html_test.rb",
    "test/munger/item_test.rb",
    "test/munger/new_test.rb",
    "test/munger/render_test.rb",
    "test/munger/report_test.rb",
    "test/munger/text_test.rb"]

  s.add_dependency "builder"

  s.add_development_dependency "rake"
  s.add_development_dependency "minitest", "~>5.0.8"
end
