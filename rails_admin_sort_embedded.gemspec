# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_admin_sort_embedded/version'

Gem::Specification.new do |gem|
  gem.name          = "rails_admin_sort_embedded"
  gem.version       = RailsAdminSortEmbedded::VERSION
  gem.authors       = ["Alexander Kiseliev", "Gleb Tv"]
  gem.email         = ["i43ack@gmail.com", "glebtv@gmail.com"]
  gem.description   = %q{Rails admin sort for embedded collections based on nested set}
  gem.summary       = %q{Interface for editing a sorted embedded collections for rails_admin}
  gem.homepage      = "https://github.com/ack43/rails_admin_sort_embedded"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rails_admin"
end
