# frozen_string_literal: true

require 'rake'

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new
rescue LoadError
  task :spec do
    abort 'You don\'t have rspec installed.'
  end
end
task test: :spec
task default: :spec
