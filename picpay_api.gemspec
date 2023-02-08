# frozen_string_literal: true

require_relative "lib/picpay_api/version"

Gem::Specification.new do |spec|

  spec.name          = 'picpay_api'
  spec.version       = PicPayApi::VERSION
  spec.authors       = ['Latam Gateway']
  spec.email         = ['nikola.haralamov@elando.com']

  spec.summary       = 'Wrapper classes for the PicPay REST API'
  spec.description   = 'Contains classes which can be used to perform PicPay payments using the PicPay Credit Remittance API'
  spec.homepage      = 'https://github.com/latamgateway/picpay_api'
  spec.required_ruby_version = '>= 3.2.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage + '/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

end