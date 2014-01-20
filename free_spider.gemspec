# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'free_spider/version'

Gem::Specification.new do |spec|
  spec.name          = "free_spider"
  spec.version       = FreeSpider::VERSION
  spec.authors       = ["free"]
  spec.email         = ["747549945@qq.com"]
  spec.description   = %q{Write a gem description}
  spec.summary       = %q{Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir["{lib}/**/*"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # 依赖的gem
  spec.add_dependency "nokogiri", ">=2.0.0"

  # 开发工具gem
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
