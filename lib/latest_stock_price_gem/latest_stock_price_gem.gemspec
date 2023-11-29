require_relative "lib/latest_stock_price_gem/version"

Gem::Specification.new do |spec|
  spec.name          = "latest_stock_price_gem"
  spec.version       = "1.0.0"
  spec.authors       = "Sang Ngo"
  spec.email         = "ngovansang.gl@gmail.com"
  spec.summary       = "Set later"
  spec.description   = "Set later"
  spec.homepage      = "Set later"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*.rb"]

  spec.add_runtime_dependency "httparty", "~> 0.18.1"
end