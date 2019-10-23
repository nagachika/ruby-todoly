Gem::Specification.new do |spec|
  spec.name          = "todoly"
  spec.version       = "0.0.2"
  spec.date          = %q{2010-12-29}
  spec.authors       = ["nagachika"]
  spec.email         = ["nagachika@ruby-lang.org"]

  spec.summary       = %q{Todo.ly REST API Library.}
  spec.description   = %q{Todo.ly REST API Library.}
  spec.homepage      = %q{http://github.com/nagachika/ruby-todoly}

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = %q{http://github.com/nagachika/ruby-todoly}

  spec.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  spec.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/todoly.rb",
    "lib/todoly/filter.rb",
    "lib/todoly/project.rb",
    "lib/todoly/rest_interface.rb",
    "lib/todoly/task.rb",
    "spec/spec_helper.rb",
    "spec/todoly_spec.rb",
    "todoly.gemspec"
  ]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency "rest-client"
end
