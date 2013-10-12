# -*- encoding: utf-8 -*-
require File.expand_path("../lib/remunger/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "remunger"
  spec.version       = Remunger::VERSION
  spec.summary       = "A report data munger in Ruby."
  spec.description   = "Remunger is a report munger written in Ruby to aid in the processing and display of tabular data."
  spec.authors       = ["Don Morrison"]
  spec.email         = ["don@elskwid.net"]
  spec.homepage      = "http://github/elskwid/remunger"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = `git ls-files -- test/*`.split("\n")
  spec.require_paths = ["lib"]

  spec.add_dependency "builder"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~>5.0.8"
end
