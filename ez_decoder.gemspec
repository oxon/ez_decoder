# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ez_decoder/version"

Gem::Specification.new do |s|
  s.name        = "ez_decoder"
  s.version     = EzDecoder::VERSION
  s.authors     = ["Yves Senn"]
  s.email       = ["yves.senn@garaio.com"]
  s.homepage    = ""
  s.summary     = %q{Gem zum parsen der Koderzeile von roten und orangen Einzahlungsscheinen}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "ez_decoder"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
