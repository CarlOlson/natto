# coding: utf-8
require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/clean'
CLEAN.include('pkg/*.gem')
CLOBBER.include('pkg')

desc "Run unit tests"
task :test do
  ruby %{ test/test_natto.rb }
end

desc "Run benchmarks"
task :benchmark do
  ruby %{ benchmark/bench_parse.rb }
end

task :default => [:test]
