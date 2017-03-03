require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task' unless ENV['CI' == 'true']

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
end

task default: :test

desc "start an IRB session to work interactively with the MarkMaker code"
task :console do
  exec "irb -r mark_maker -I ./lib"
end

if ENV['CI' != 'true']
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.patterns = ['lib/**/*.rb']
  end
end

desc "generate the readme file for the project programatically using MarkMaker"
task :readme do
  exec "ruby -Ilib bin/generate_readme.rb > README.md"
end
