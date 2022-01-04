require_relative 'lib/budget_update_script/version'

Gem::Specification.new do |spec|
  spec.name          = "budget_update_script"
  spec.version       = BudgetUpdateScript::VERSION
  spec.authors       = ["Andre LaFleur"]
  spec.email         = ["cincospenguinos@gmail.com"]

  spec.summary       = %q{A simple script to munge my data. Probably will never be published.}
  spec.description   = %q{A simple script to munge my financial data. Will probably never be published because I don't want it floating around}
  spec.homepage      = "http://example.com"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = ""

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://example.com"
  spec.metadata["changelog_uri"] = "http://example.com"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = ['budget_update_script']
  spec.require_paths = ["lib"]
end
