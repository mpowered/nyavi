# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "nyavi/version"

Gem::Specification.new do |s|
  s.name        = "nyavi"
  s.version     = Nyavi::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mpowered"]
  s.email       = ["mpowered.development@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{YAML powered site navigation}
  s.description = %q{Easily manage navigation menus and active items with Nyavi and it's YAML files}

  s.rubyforge_project = "nyavi"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
