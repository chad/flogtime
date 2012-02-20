# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "flogtime/version"

Gem::Specification.new do |s|
  s.name        = "flogtime"
  s.version     = Flogtime::VERSION
  s.authors     = ["Chad Fowler"]
  s.email       = ["chad@chadfowler.com"]
  s.homepage    = "http://github.com/chad/flogtime"
  s.summary     = %q{Flog score over time}
  s.description = %q{Generate flog totals and method averages over time for a given file in a git repo}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "flog"
  s.add_runtime_dependency "grit"
end
