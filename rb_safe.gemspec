# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rb_safe/version'

Gem::Specification.new do |spec|
  spec.name          = "rb_safe"
  spec.version       = RbSafe::VERSION
  spec.authors       = ["lord63"]
  spec.email         = ["lord63.j@gmail.com"]

  spec.summary       = %q{Check the password's strength for you.}
  spec.description   = <<-EOF
    RbSafe will check the password's strength for you:

    *. password's length
    *. contain lower letters, upper letters, numbers and marks
    *. in the order on the keyboard
    *. simple alphabet by step
    *. common used passwords
  EOF
  spec.homepage      = "https://github.com/lord63/rb_safe"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
