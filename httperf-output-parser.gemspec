# -*- encoding: utf-8 -*-
require File.expand_path('../lib/httperf-output-parser/version', __FILE__)

Gem::Specification.new do |gem|
	gem.authors       = ["Will Jessop"]
	gem.email         = ["will@willj.net"]
	gem.description   = %q{httperf output parser}
	gem.summary       = %q{httperf output parser}
	gem.homepage      = "https://github.com/wjessop/httperf-output-parser"

	gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
	gem.files         = `git ls-files`.split("\n")
	gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
	gem.name          = "httperf-output-parser"
	gem.require_paths = ["lib"]
	gem.version       = HttperfOutputParser::VERSION
  
	gem.add_development_dependency 'simplecov'
end
