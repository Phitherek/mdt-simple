require_relative './lib/mdt/version'

Gem::Specification.new do |s|
  s.name = 'mdt-simple'
  s.version = MDT::Simple::VERSION
  s.date = '2018-03-02'
  s.summary = 'MDT Simple module'
  s.description = 'A module with simple implementations for MDT'
  s.authors = ['Phitherek_']
  s.email = ['phitherek@gmail.com']
  s.files = Dir['lib/**/*.rb']
  s.homepage = 'https://github.com/Phitherek/mdt-simple'
  s.license = 'MIT'
  s.extra_rdoc_files = ['README.md']
  s.rdoc_options << '--title' << 'MDT Simple module' << '--main' << 'README.md' << '--line-numbers'
  s.metadata = {
      'documentation_uri' => 'http://www.rubydoc.info/github/Phitherek/mdt-simple',
      'source_code_uri' => 'https://github.com/Phitherek/mdt-simple'
  }
  s.add_runtime_dependency 'mdt-core', '~> 0.0'
  s.add_development_dependency 'rspec', '~> 3.7'
end
