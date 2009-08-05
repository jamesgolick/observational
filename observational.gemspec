# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{observational}
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Golick"]
  s.date = %q{2009-08-05}
  s.email = %q{james@giraffesoft.ca}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/observational.rb",
     "lib/observational/active_record_observers.rb",
     "lib/observational/observable.rb",
     "lib/observational/observer.rb",
     "observational.gemspec",
     "rails/init.rb",
     "spec/active_record_observers_spec.rb",
     "spec/observable_spec.rb",
     "spec/observational_spec.rb",
     "spec/observer_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/giraffesoft/observational}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}
  s.test_files = [
    "spec/active_record_observers_spec.rb",
     "spec/observable_spec.rb",
     "spec/observational_spec.rb",
     "spec/observer_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
