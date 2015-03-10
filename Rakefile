require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
end

task :default => :test

task :console do
	exec "irb -r mark_maker -I ./lib"
end