desc 'Run all tests by default'
task :default => %w(test)

desc 'Run all tests'
task :test do
  $LOAD_PATH.unshift('lib', 'spec')
  Dir.glob('./spec/**/*_spec.rb') { |f| require f }
end
