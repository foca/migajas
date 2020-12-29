require "./lib/migajas/version"

Gem::Specification.new do |s|
  s.name        = "migajas"
  s.licenses    = ["MIT"]
  s.version     = Migajas::VERSION
  s.summary     = "Breadcrumbs for your Rack app"
  s.description = "Simple library to add breadcrumbs to your Rack app"
  s.authors     = ["Nicolas Sanguinetti"]
  s.email       = ["foca@foca.io"]
  s.homepage    = "http://github.com/foca/migajas"

  s.files = Dir[
    "LICENSE",
    "README.md",
    "lib/migajas.rb",
    "lib/migajas/rails.rb",
    "lib/migajas/version.rb",
  ]

  s.add_development_dependency "cutest", "~> 1.2"
  s.add_development_dependency "cuba", "~> 3.0"
end
