require 'rake'
require 'transdeps/cli'

desc 'Print all the dependency inconsistencies. root_dir is optional.'
task :transdeps, [:component_dir, :root_dir] do |_, args|
  if args[:root_dir]
    puts Transdeps::Cli.new(args[:component_dir], args[:root_dir]).run
  else
    warn 'WARNING: Using PWD as project root_dir'
    puts Transdeps::Cli.new(args[:component_dir]).run
  end
end