$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require 'unidom/certificate/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'unidom-certificate'
  spec.version     = Unidom::Certificate::VERSION
  spec.authors     = [ 'Topbit Du' ]
  spec.email       = [ 'topbit.du@gmail.com' ]
  spec.homepage    = 'https://github.com/topbitdu/unidom-certificate'
  spec.summary     = 'The Certificate domain model engine includes Identity Card and Business License models.'
  spec.description = 'Unidom (UNIfied Domain Object Model) is a series of domain model engines. The Certificate domain model engine includes Identity Card and Business License models. Unidom (统一领域对象模型)是一系列的领域模型引擎。证书领域模型引擎包括身份证和营业执照的模型。'
  spec.license     = 'MIT'

  spec.files         = Dir[ '{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md' ]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = [ 'lib' ]

  spec.add_dependency 'unidom-common', '~> 0.2'

end
