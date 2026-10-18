# frozen_string_literal: true

require_relative "lib/uk_bank_validator/version"

Gem::Specification.new do |spec|
  spec.name = "uk_bank_validator"
  spec.version = UkBankValidator::VERSION
  spec.authors = ["Miral Desai"]
  spec.email = ["13769268+MiralDesai@users.noreply.github.com"]

  spec.summary = "Fast local validation and normalisation of UK account numbers and sort codes"
  spec.description = <<~DESCRIPTION.strip
    Validates and normalises UK bank account numbers and sort codes locally, with zero network
    calls and no runtime dependencies. Returns structured errors and the normalised values ready to use.
  DESCRIPTION
  spec.homepage = "https://github.com/MiralDesai/uk_bank_validator"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.4"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "#{spec.homepage}/tree/v#{spec.version}"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/v#{spec.version}/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Include only files tracked by git, minus development-only paths.
  gemspec = File.basename(__FILE__)
  development_files = %w[.rspec .rubocop.yml .ruby-version Rakefile].freeze
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |file|
      (file == gemspec) ||
        file.start_with?(*%w[bin/ spec/ features/ .git .github Gemfile]) ||
        development_files.include?(file)
    end
  end
  spec.require_paths = ["lib"]
end
