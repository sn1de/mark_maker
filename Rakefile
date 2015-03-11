require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
end

task default: :test

task :console do
  exec "irb -r mark_maker -I ./lib"
end

RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb']
end

task :readme do
  exec "ruby -Ilib bin/generate_readme.rb > README.md"
end

