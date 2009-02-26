# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sms_xchange}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Scott Barr"]
  s.date = %q{2009-02-26}
  s.description = %q{Ruby client for the smsxchange.com service.}
  s.email = %q{scottb@globalitcreations.com}
  s.extra_rdoc_files = ["lib/sms_xchange.rb", "README"]
  s.files = ["config.yml", "init.rb", "lib/sms_xchange.rb", "Manifest", "Rakefile", "README", "test/mocks/sms_xchange_mock.rb", "test/test_helper.rb", "test/unit/sms_xchange_test.rb", "sms_xchange.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://wiki.globalitcreations.com:8668/space/SMS+Xchange}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Sms_xchange", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{sms_xchange}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Ruby client for the smsxchange.com service.}
  s.test_files = ["test/test_helper.rb", "test/unit/sms_xchange_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
