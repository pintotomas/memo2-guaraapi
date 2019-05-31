require File.expand_path(File.dirname(__FILE__) + '/../../config/boot')

require 'capybara/cucumber'
require 'rspec/expectations'

require 'simplecov'

SimpleCov.start do
  root(File.join(File.dirname(__FILE__), '..', '..'))
  coverage_dir 'reports/coverage'
  add_filter '/spec/'
  add_filter '/features/'
  add_filter '/admin/'
  add_filter '/db/'
  add_filter '/config/'
  add_group 'Models', 'app/models'
  add_group 'Controllers', 'app/controllers'
  add_group 'Helpers', 'app/helpers'
end

subject_repository = SubjectRepository.new
unless subject_repository.all.count.positive?
  subject = Subject.new(name: 'Seguridad Nuclear',
                        professor: 'Homero',
                        code: '9999')

  subject_repository.save(subject)
end

Around do |_scenario, block|
  DB.transaction(rollback: :always, auto_savepoint: true) { block.call }
end

# Capybara.default_driver = :selenium
Capybara.app = GuaraApi::App.tap { |app| }
